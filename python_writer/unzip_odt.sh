
# python odt_to_xml.py $1 &&
odt_file="$1"

if [[ --n $odt_file ]];
then
  exit 1
fi 

echo cp "$odt_file" temp/
cp "$odt_file" temp/
odt_file=temp/${odt_file##*/}
echo "$odt_file"

# Remove ext
dir="${odt_file%.*}"

# Log file directory
rm -r log/
mkdir log/

# Remove existing unzipped book
rm -r "$dir" #2>/dev/null
mkdir -p "$dir"

# Unzip BookTitle.odt
unzip "$odt_file" -d "$dir"
