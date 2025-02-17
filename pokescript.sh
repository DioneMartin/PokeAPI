# Verificar que se proporcionó un argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <nombre_pokemon>"
    exit 1
fi

# URL de la API 
API_URL="https://pokeapi.co/api/v2/pokemon/$1"

# Uso de curl
response=$(curl -s "$API_URL")

# Extraer datos con jq
id=$(echo "$response" | jq '.id')
name=$(echo "$response" | jq -r '.name')
weight=$(echo "$response" | jq '.weight')
height=$(echo "$response" | jq '.height')
order=$(echo "$response" | jq '.order')

# Imprimir los datos
echo "$name (No. $id)"
echo "Id = $id"
echo "Weight = $weight"
echo "Height = $height"
echo "Order = $order"

# Guardar en CSV
CSV_FILE="pokemon_data.csv"

# Si el archivo no existe, agregar la cabecera
if [ ! -f "$CSV_FILE" ]; then
    echo "id,name,weight,height,order" > "$CSV_FILE"
fi

# Agregar los datos al CSV
echo "$id,$name,$weight,$height,$order" >> "$CSV_FILE"
