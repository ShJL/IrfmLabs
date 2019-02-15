import sys
sys.path.append("../../tools")

import laba


laba.process("../specialities.xml", "../script.sql")
laba.add_inserts("../specialities.xml", "../sql_insert.xsl", "../script.sql")
