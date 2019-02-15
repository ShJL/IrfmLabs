import sys
sys.path.append("../../tools")

import laba


laba.process("../a_groups.xml", "../script.sql", False)
laba.add_inserts("../a_groups.xml", "../sql_insert.xsl", "../script.sql")
