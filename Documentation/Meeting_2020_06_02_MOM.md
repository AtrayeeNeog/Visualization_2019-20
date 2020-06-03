* Template and Graphs:
	* Check if Seeds appear in Graph.
	* Make a list of  nodes which appear in more than one Channel.
	* Find nodes above the overall minimum degree for the Channel
	* Check the number of different roles for all nodes based on Source and Target.
	* Travel Channel:

		a. Check the nodes with exact same attributes (Target, Time, Weight, Source Location)

		b. Check different combinations(Time, Target always present)

		c. Derive how to select the nodes

		d. Check Nodes with just one travel history or no common travel history with any other nodes in the list extracted earlier (of nodes appearing in more than one channel) and delete the ones which are not in the list.

	* Procurement Channel:

		a. Check for pairs of etypes 2 and 3 and if there are items with either only 2 or a 3 etype then check those in the common list and discard the ones which do not appear there.

		b. Extract the people and remove the items.

		c. Frequency of buying and selling for the nodes.

	* Co-Authorship Channel:

		a. Check the different Sources (persons) who have written the same paper (same Target)

		b. Check the different targets with same Source
		
		c. Derive a way to extract nodes from the Seed.
