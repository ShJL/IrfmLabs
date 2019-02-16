import sys
sys.path.append("../../tools")

import laba


laba.process("../plans.xml", "../script.sql")
laba.add_inserts("../plans.xml", "../sql_insert.xsl", "../script.sql")
