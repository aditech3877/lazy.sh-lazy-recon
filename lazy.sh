 
  

      subfinder -d $1 | tee -a all.txt 
      assetfinder -subs-only $1 | tee -a all.txt 
      
      waybackurls $1 | tee -a way.txt 
      curl https://crt.sh/?q=$1 | grep "*" | tee - a star.txt 
      
      #!/bin/bash

# Input file
input_file="star.txt"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

# Extract domains
domains=$(grep -oP '(?<=\*\.)([a-zA-Z0-9.-]+)(?=<)' "$input_file")

# Remove duplicates
unique_domains=$(echo "$domains" | sort -u)

# Print the result
echo "$unique_domains" | tee -a enum.txt

subfinder -dL enum.txt | tee -a all.txt

cat way.txt | grep .js | httpx -mc 200 | tee js.txt








