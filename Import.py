import sqlite3
import sys
import xml.etree.ElementTree as ET

# Incoming Pokemon MUST be in this format
#
# <pokemon pokedex="" classification="" generation="">
#     <name>...</name>
#     <hp>...</name>
#     <type>...</type>
#     <type>...</type>
#     <attack>...</attack>
#     <defense>...</defense>
#     <speed>...</speed>
#     <sp_attack>...</sp_attack>
#     <sp_defense>...</sp_defense>
#     <height><m>...</m></height>
#     <weight><kg>...</kg></weight>
#     <abilities>
#         <ability />
#     </abilities>
# </pokemon>



# Read pokemon XML file name from command-line
# (Currently this code does nothing; your job is to fix that!)
if len(sys.argv) < 2:
    print("You must pass at least one XML file name containing Pokemon to insert")

for i, arg in enumerate(sys.argv):
    # Skip if this is the Python filename (argv[0])
    if i == 0:
        continue

    # Parse the XML file
    tree = ET.parse(arg)
    root = tree.getroot()

    # Extract data from the XML and store it in variables
    pokedex = root.attrib['pokedex']
    classification = root.attrib['classification']
    generation = root.attrib['generation']
    name = root.find('name').text
    hp = root.find('hp').text
    types = root.findall('type')
    type1 = types[0].text
    type2 = types[1].text if len(types) > 1 else None
    attack = root.find('attack').text
    defense = root.find('defense').text
    speed = root.find('speed').text
    sp_attack = root.find('sp_attack').text
    sp_defense = root.find('sp_defense').text
    height = root.find('height/m').text
    weight = root.find('weight/kg').text
    abilities = [ability.attrib['name'] for ability in root.findall('abilities/ability')]

    # Connect to the database
    conn = sqlite3.connect('pokemon.sqlite')
    c = conn.cursor()

    # Insert the new Pokemon into the database
    c.execute("INSERT INTO pokemon (pokedex_number, name, classification, generation, type1, type2, hp, attack, defense, speed, sp_attack, sp_defense, height, weight) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
              (pokedex, name, classification, generation, type1, type2, hp, attack, defense, speed, sp_attack, sp_defense, height, weight))
    pokemon_id = c.lastrowid

    for ability in abilities:
        c.execute("INSERT INTO pokemon_abilities (pokemon_id, ability) VALUES (?, ?)", (pokemon_id, ability))

    # Commit the changes and close the connection
    conn.commit()
    conn.close()

print("All Pokemon have been successfully inserted into the database.")