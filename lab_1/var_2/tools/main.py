import sys
sys.path.append("../../tools")

import laba


laba.run_all("../plans.xml", "../sql_insert.xsl", "../script.sql", duplicates=False)
