#  ____________________________________________________________¬
#  Generate automatic video titles for kdenlive from text file.
#                          Version 1.0.0
#               Author: Julian David (@juliandavidmr)
#                         Licence MIT 2017
# _____________________________________________________________

# Validate arguments 
if [ ! -f $1 ]; then
	echo "$1 is not file."
	exit 1
fi

# Magic
function help {
	echo "Generate titles kdenlive from csv, txt..."
}

function each_line {

	# Create folder output titles
	mkdir out_titles

	while IFS= read -r line; do
		# Split line by ;
		IN="$line"
		set -- "$IN" 
		IFS=";"; declare -a Array=($*) 
		echo "Generating the ${Array[@]} title..." 
		# echo "${Array[0]}" 
		# echo "${Array[1]}"

		# Set xml file
		xmlstarlet edit -L -u "/kdenlivetitle/item[@z-index='3']/content" -v "${Array[0]}" template.kdenlivetitle
		xmlstarlet edit -L -u "/kdenlivetitle/item[@z-index='2']/content" -v "${Array[1]}" template.kdenlivetitle

		# Copy file
		cp ./template.kdenlivetitle ./out_titles/"title-${Array[0]}.kdenlivetitle"
	done < $1
}

help
each_line $1