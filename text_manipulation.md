# TEXT MANIPULATION
 
## Remove comment
sed -i '/<Valve/s/<!-- //' context.xml
sed -i '/allow="127/s/ -->//' context.xml