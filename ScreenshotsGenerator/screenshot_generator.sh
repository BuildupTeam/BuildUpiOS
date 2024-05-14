#!/bin/bash

# Define the JSON configuration as a variable
read -r -d '' CONFIGURATION <<'EOF'
{
  "iPhone 6.7": {
    "files": {
      "iPhone 6.7 Inches - Login.png": "iPhone 14 Plus-LoginViewController.png",
      "iPhone 6.7 Inches - Home.png": "iPhone 14 Plus-HomeViewController.png",
      "iPhone 6.7 Inches - Categories.png": "iPhone 14 Plus-CategoriesTabViewController.png"
    },
    "mock_width": "831",
    "mock_height": "1754",
    "mt": "702",
    "ml": "229",
    "output": "screen_output/6.7"
  },
  "iPhone 6.5": {
    "files": {
      "6.5-inch Login.png": "iPhone 14 Plus-LoginViewController.png",
      "6.5-inch Home.png": "iPhone 14 Plus-HomeViewController.png",
      "6.5-inch Categories.png": "iPhone 14 Plus-CategoriesTabViewController.png"
    },
    "mock_width": "833",
    "mock_height": "1762",
    "mt": "702",
    "ml": "207",
    "output": "screen_output/6.5"
  },
  "iPhone 5.5": {
    "files": {
      "iPhone 5.5 Inches - Login.png": "iPhone 14 Plus-LoginViewController.png",
      "iPhone 5.5 Inches - Home.png": "iPhone 14 Plus-HomeViewController.png",
      "iPhone 5.5 Inches - Categories.png": "iPhone 14 Plus-CategoriesTabViewController.png"
    },
    "mock_width": "751",
    "mock_height": "1594",
    "mt": "481",
    "ml": "245",
    "output": "screen_output/5.5"
  },
  "iPad 12.9": {
    "files": {
      "iPad 12.9 Inches - Login.png": "iPhone 14 Plus-LoginViewController.png",
      "iPad 12.9 Inches - Home.png": "iPhone 14 Plus-HomeViewController.png",
      "iPad 12.9 Inches - Categories.png": "iPhone 14 Plus-CategoriesTabViewController.png"
    },
    "mock_width": "1276",
    "mock_height": "1827",
    "mt": "668",
    "ml": "385",
    "output": "screen_output/12.9"
  }
}
EOF

baseUrl="$PROJECT_PATH/ScreenshotsGenerator"

# Loop through each device configuration
echo "$CONFIGURATION" | jq -c 'to_entries[]' | while read -r entry; do
  device=$(echo "$entry" | jq -r '.key')
  mock_width=$(echo "$entry" | jq -r '.value.mock_width')
  mock_height=$(echo "$entry" | jq -r '.value.mock_height')
  mt=$(echo "$entry" | jq -r '.value.mt')
  ml=$(echo "$entry" | jq -r '.value.ml')
  output=$(echo "$entry" | jq -r '.value.output')

  # Loop through each file pair
  echo "$entry" | jq -c '.value.files | to_entries[]' | while read -r file; do
    overlay="$baseUrl/$device/"$(echo "$file" | jq -r '.key')
    base="$PROJECT_PATH/fastlane/screenshots/en-US/"$(echo "$file" | jq -r '.value')

    echo "Processing $overlay with $base for $device..."

    # Perform the image manipulation
    identify -format "%wx%h" "$overlay" > "$baseUrl/dimensions.txt" && read WIDTH HEIGHT < "$baseUrl/dimensions.txt"
    convert -size "${WIDTH}x${HEIGHT}"! xc:black -colorspace sRGB "$baseUrl/black.png"
    convert "$base" -resize ${mock_width}x${mock_height}! -colorspace sRGB "$baseUrl/resized_base.png"
    composite -geometry +${ml}+${mt} "$baseUrl/resized_base.png" "$baseUrl/black.png" -colorspace sRGB "$baseUrl/positioned_base.png"
    mkdir -p "$baseUrl/$output"
    convert "$baseUrl/positioned_base.png" "$overlay" -composite -colorspace sRGB "$baseUrl/$output/$(basename "$overlay")"
#
    echo "Finished processing $overlay..."
  done
done