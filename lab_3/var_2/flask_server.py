import flask
import sqlite3

import db.sql_consts as sc


_OK = 200
_BAD_REQUEST = 400
_NOT_FOUND = 404


app = flask.Flask(__name__)


def _get_db():
    db = getattr(flask.g, "_db_connection", None)
    if db is None:
        db = flask.g._db_connection = sqlite3.connect(sc.DATABASE)
        db.row_factory = lambda c, r: {x[0]: r[i] for i, x in enumerate(c.description)}
    return db


def _query_db(query, args=(), select=True):
    db = _get_db().execute(query, args)
    if select:
        return db.fetchall()
    _get_db().commit()


def _exists(obj_id):
    return len(_query_db(f"select 1 from {sc.SQL_TABLE} where id = ?", [obj_id])) == 1


def _response(method, oid, status):
    return flask.jsonify({"method": method, "id": oid, "status": status})


def _extend_params(args):
    params = args.to_dict()
    for field in sc.SQL_COLUMNS:
        if field not in params:
            params[field] = None
    return params


_GTD_PREFIX = "/api/gtd"


@app.route("/api/")
def api_index():
    return flask.render_template("index.html")


@app.route(_GTD_PREFIX + "/", methods=["GET"])
def gtd_index():
    list_objs = _query_db(f"select * from {sc.SQL_TABLE}")
    return flask.jsonify({"total": len(list_objs), "rows": list_objs})


@app.route(_GTD_PREFIX + "/<int:obj_id>", methods=["GET"])
def gtd_show(obj_id):
    if not _exists(obj_id):
        flask.abort(_NOT_FOUND)
    return flask.jsonify(
        _query_db(f"select * from {sc.SQL_TABLE} where id = ?", [obj_id])[0]
    )


@app.route(_GTD_PREFIX, methods=["POST"])
@app.route(_GTD_PREFIX + "/<int:obj_id>", methods=["POST"])
def gtd_create(obj_id=None):
    args = _extend_params(flask.request.args)

    add_col = tuple()
    add_ph = tuple()
    if obj_id is not None:
        args["id"] = obj_id
        add_col = ("id",)
        add_ph = (":id",)

    _query_db(
        f"""insert into {sc.SQL_TABLE}
            ({','.join(sc.SQL_COLUMNS + add_col)})
        values
            ({','.join(sc.SQL_PLACEHOLDERS + add_ph)})""",
        args,
        False
    )

    if obj_id is None:
        obj_id = _query_db(f"select id from {sc.SQL_TABLE} where rowid = last_insert_rowid()")[0]["id"]
    return _response("create", obj_id, _OK)


@app.route(_GTD_PREFIX + "/<int:obj_id>", methods=["PUT"])
def gtd_update(obj_id):
    if not _exists(obj_id):
        flask.abort(_NOT_FOUND)

    args = _extend_params(flask.request.args)
    args["id"] = obj_id

    _query_db(
        f"update {sc.SQL_TABLE} set {','.join(sc.SQL_FULL_MATCHING)} where id = :id",
        args,
        False
    )
    return _response("update", obj_id, _OK)


@app.route(_GTD_PREFIX + "/<int:obj_id>", methods=["DELETE"])
def gtd_destroy(obj_id):
    if not _exists(obj_id):
        flask.abort(_NOT_FOUND)
    _query_db(f"delete from {sc.SQL_TABLE} where id = ?", [obj_id], False)
    return _response("delete", obj_id, _OK)


@app.route(_GTD_PREFIX + "/number/<int:month>", methods=["GET"])
def gtd_number_of_attacks(month):
    if month < 1 or 12 < month:
        flask.abort(_BAD_REQUEST)
    return flask.jsonify(
        _query_db(f"select count(*) as count from {sc.SQL_TABLE} where imonth = ?", [month])[0]
    )


@app.teardown_appcontext
def close_connection(exception):
    db = flask.g.pop("_db_connection", None)
    if db is not None:
        db.commit()
        db.close()
