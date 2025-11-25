# Multi-Language Name Support

## Available Name CSV Files

The badge system now supports names from 4 different languages:

### 1. **English Names** (`names.csv`)
- 20 common English first and last names
- Examples: James Smith, Mary Johnson, John Williams

### 2. **Romanian Names** (`names_romanian.csv`)
- 20 common Romanian first and last names
- Examples: Ion Popescu, Maria Ionescu, Gheorghe Popa

### 3. **Hungarian Names** (`names_hungarian.csv`)
- 20 common Hungarian first and last names
- Examples: István Nagy, Katalin Kovács, László Tóth
- Includes Hungarian characters: á, é, í, ó, ö, ő, ú, ü, ű

### 4. **Chinese Names** (`names_chinese.csv`)
- 20 common Chinese first and last names (Pinyin)
- Examples: Wei Wang, Ling Li, Jun Zhang

## How to Use

### Method 1: Direct CSV File Selection

```python
# English (default)
random_name = get_random_name("names.csv")

# Romanian
random_name = get_random_name("names_romanian.csv")

# Hungarian
random_name = get_random_name("names_hungarian.csv")

# Chinese
random_name = get_random_name("names_chinese.csv")
```

### Method 2: Language Helper Function

```python
# English
random_name = get_random_name_by_language("english")

# Romanian
random_name = get_random_name_by_language("romanian")

# Hungarian
random_name = get_random_name_by_language("hungarian")

# Chinese
random_name = get_random_name_by_language("chinese")
```

## Test All Languages

Run the test script to see all languages in action:

```powershell
C:/LegacyApp/Python311/python.exe test_all_languages.py
```

This will:
- Display random names from each language
- Create 4 badge files (one for each language)
- Save as: `badge_english.png`, `badge_romanian.png`, `badge_hungarian.png`, `badge_chinese.png`

## Editing the CSV Files

Each CSV file has the same format:

```csv
first_name,last_name
Name1,Surname1
Name2,Surname2
...
```

You can:
- Add more names to any CSV file
- Create new CSV files for other languages
- Edit existing names

## Adding a New Language

1. Create a new CSV file: `names_newlanguage.csv`
2. Add names in the format: `first_name,last_name`
3. Use it:
   ```python
   random_name = get_random_name("names_newlanguage.csv")
   ```

## Current Implementation

- Names are automatically converted to **UPPERCASE** on the badge
- All CSV files use UTF-8 encoding (supports special characters)
- Each CSV contains 20 names (can be extended)
