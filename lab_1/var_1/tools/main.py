import sys
sys.path.append("../../tools")

import laba


laba.run_all("../specialities.xml", "../sql_insert.xsl", "../script.sql")
