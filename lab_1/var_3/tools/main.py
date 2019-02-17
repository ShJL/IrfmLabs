import sys
sys.path.append("../../tools")

import laba


laba.run_all("../a_groups.xml", "../sql_insert.xsl", "../script.sql", duplicates=False)
