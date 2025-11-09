Rules:
1. Input validation scripts should be included as libraries.
2. If the role can be done as library script, do NOT make it as singletons.
3. Before accessing an non-ready/export referenced node, validate if it exist or not 

Order of scripting:
1. Class declaration
2. inheritance declaration
3. export variables (non-referenced nodes)
4. export variables (referenced nodes)
5. onready variables
6. normal variables
7. "_" functions
8. boolean functions
9. get functions
10. set functions
11. normal functions
12. signal listener functions