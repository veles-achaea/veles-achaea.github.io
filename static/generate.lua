-- Define heldby to color mapping
local heldby_colors = {
  ["Mhaldor"]   = {r=255, g=0,   b=0},
  ["Targossas"] = {r=255, g=255, b=0},
  ["Ashtan"]    = {r=128, g=0,   b=128},
  ["Cyrene"]    = {r=0,   g=128, b=128},
  ["Eleusis"]   = {r=0,   g=255, b=0},
  ["Hashan"]    = {r=128, g=128, b=0},
  ["Underworld"]= {r=128, g=0,   b=0},
  ["None"]      = {r=192, g=192, b=192},
}

-- Example data source
local data = {
  nodes = {
    {id="Ghezavat Commune", label="Ghezavat", heldby="None", size=5.67, x=-415.86, y=-252.44},
    {id="Mhojave Desert, the (Central)", label="Mhojave", heldby="Mhaldor", size=9.0, x=-456.34, y=-225.16},
    -- Add more nodes...
  },
  edges = {
    {id=0, source="Ghezavat Commune", target="Mhojave Desert, the (Central)"},
    -- Add more edges...
  }
}

-- Helper to escape XML
local function xml_escape(str)
  return (str:gsub("[<>&\"]", {
    ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;", ["\""] = "&quot;"
  }))
end

-- Generate node XML
local function node_xml(node)
  local color = heldby_colors[node.heldby or "None"] or heldby_colors["None"]
  return string.format([[
      <node id="%s" label="%s">
        <attvalues>
          <attvalue for="heldby" value="%s"/>
        </attvalues>
        <viz:size value="%.7g"/>
        <viz:position x="%.7g" y="%.7g"/>
        <viz:color r="%d" g="%d" b="%d"/>
      </node>]],
    xml_escape(node.id), xml_escape(node.label), xml_escape(node.heldby or "None"),
    node.size or 5.67, node.x or 0, node.y or 0,
    color.r, color.g, color.b
  )
end

-- Generate edge XML
local function edge_xml(edge)
  return string.format([[      <edge id="%s" source="%s" target="%s"/>]],
    tostring(edge.id), xml_escape(edge.source), xml_escape(edge.target)
  )
end

-- Generate the full GEXF XML
local function generate_gexf(data)
  local nodes_xml, edges_xml = {}, {}
  for _, node in ipairs(data.nodes) do
    table.insert(nodes_xml, node_xml(node))
  end
  for _, edge in ipairs(data.edges) do
    table.insert(edges_xml, edge_xml(edge))
  end

  return string.format([[<?xml version='1.0' encoding='UTF-8'?>
<gexf xmlns="http://gexf.net/1.3" version="1.3" xmlns:viz="http://gexf.net/1.3/viz" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://gexf.net/1.3 http://gexf.net/1.3/gexf.xsd">
  <meta lastmodifieddate="%s">
    <creator>Lua Script</creator>
    <title></title>
    <description></description>
  </meta>
  <graph defaultedgetype="directed" mode="static">
    <attributes class="node" mode="static">
      <attribute id="heldby" title="HeldBy" type="string"/>
    </attributes>
    <nodes>
%s
    </nodes>
    <edges>
%s
    </edges>
  </graph>
</gexf>
]], os.date("%Y-%m-%d"), table.concat(nodes_xml, "\n"), table.concat(edges_xml, "\n"))
end

-- Example usage: print or write to file
local gexf_xml = generate_gexf(data)
print(gexf_xml)
-- To write to file:
-- local f = io.open("conquest-map.gexf", "w"); f:write(gexf_xml); f:close()




------------------------

local nodes = {
  {id="Ghezavat Commune", label="Ghezavat", heldby="None", size=5.6666665, x=-415.86392, y=-252.43979},
  {id="Mhojave Desert, the (Central)", label="Mhojave", heldby="Mhaldor", size=9.0, x=-456.34305, y=-225.15671},
  {id="Southern Wilderness", label="Southern Wilderness", heldby="Targossas", size=10.333334, x=37.984085, y=35.81664},
  {id="1", label="Moghedu", heldby="Mhaldor", size=6.3333335, x=-471.53256, y=-270.96753},
  {id="Ruins of the Erisian Pyramid", label="Erisian Pyramid", heldby="Cyrene", size=5.6666665, x=-401.1484, y=-209.92174},
  {id="Savannah, the (Central)", label="Savannah", heldby="Mhaldor", size=13.666667, x=-579.27716, y=-17.842434},
  {id="Zaphar River, the", label="Zaphar", heldby="Eleusis", size=8.0, x=-2.1917028, y=313.63992},
  {id="Adryn's Keep", label="Adryn's Keep", heldby="None", size=6.3333335, x=130.3213, y=180.1496},
  {id="Central Wilderness", label="Central Wilderness", heldby="Ashtan", size=15.0, x=-199.32928, y=245.6358},
  {id="Delos, the Isle of", label="Delos", heldby="None", size=7.0, x=-48.13593, y=238.08047},
  {id="Eastern Ithmia, the", label="Eastern Ithmia", heldby="Eleusis", size=7.0, x=47.600544, y=357.64267},
  {id="Eastern Reaches", label="Eastern Reaches", heldby="Hashan", size=9.0, x=156.08592, y=140.21864},
  {id="Northern Ithmia, the", label="Northern Ithmia", heldby="Hashan", size=9.0, x=-4.561714, y=390.56317},
  {id="Peshwar Delta", label="Peshwar Delta", heldby="Hashan", size=7.666667, x=-83.11102, y=-59.34764},
  {id="Western Ithmia, the", label="Western Ithmia", heldby="Eleusis", size=9.0, x=-88.93239, y=366.82654},
  {id="2", label="Digsite of Husks", heldby="None", size=5.6666665, x=-484.95953, y=-326.15353},
  {id="Sangre Plains, the", label="Sangre Plains", heldby="Ashtan", size=8.0, x=-530.92426, y=391.73462},
  {id="Muurn Lake", label="Muurn Lake", heldby="Cyrene", size=6.3333335, x=-583.80615, y=-632.59094},
  {id="Cyrene, the City of", label="Cyrene", heldby="Cyrene", size=20.0, x=-491.86047, y=-619.10913},
  {id="Muurn River Valley", label="Muurn River Valley", heldby="Cyrene", size=7.0, x=-664.7709, y=-591.7218},
  {id="Mhaldor Isle", label="Mhaldor Isle", heldby="Mhaldor", size=7.666667, x=-1011.4326, y=0.8718147},
  {id="Isle of New Hope", label="Isle of New Hope", heldby="None", size=5.6666665, x=-60.703552, y=-142.1524},
  {id="Pachacacha River, the", label="Pachacacha River", heldby="Ashtan", size=8.333334, x=-363.5908, y=-99.868195},
  {id="Aerinewild, the", label="Aerinewild", heldby="None", size=5.6666665, x=-627.7394, y=78.642944},
  {id="Aureliana Forest, the", label="Aureliana Forest", heldby="None", size=7.666667, x=-572.31177, y=59.81111},
  {id="Bitterfork", label="Bitterfork", heldby="None", size=5.6666665, x=-426.74857, y=661.5322},
  {id="Dardanic Plains, the", label="Dardanic Plains", heldby="None", size=7.0, x=-350.42255, y=623.3632},
  {id="Vashnar Mountains, the", label="Vashnar Mountains", heldby="Mhaldor", size=8.333334, x=-674.5479, y=-291.92368},
  {id="Aalen Forest, the", label="Aalen Forest", heldby="None", size=7.0, x=-686.1001, y=-456.76086},
  {id="Dakhota Hills, the", label="Dakhota Hills", heldby="Mhaldor", size=9.666666, x=-574.91473, y=-126.05391},
  {id="Dun Valley", label="Dun Valley", heldby="Cyrene", size=5.6666665, x=-619.07086, y=-312.49094},
  {id="Thraasi Foothills", label="Thraasi Foothills", heldby="None", size=5.6666665, x=-741.473, y=-346.78296},
  {id="Hashan, the City of", label="Hashan", heldby="Hashan", size=20.0, x=30.747406, y=436.81546},
  {id="Shamtota Hills, the (West)", label="Shamtota Hills", heldby="Cyrene", size=8.333334, x=-319.15173, y=-164.16313},
  {id="Granite Hills, the", label="Granite Hills", heldby="Hashan", size=8.333334, x=-434.8495, y=519.0782},
  {id="Northern Plains", label="Northern Plains", heldby="Hashan", size=7.0, x=-232.59511, y=539.9448},
  {id="Northern Wilderness", label="Northern Wilderness", heldby="Hashan", size=10.333334, x=-163.00844, y=492.64102},
  {id="Urubamba River, the", label="Urubamba River", heldby="Ashtan", size=9.666666, x=-522.8408, y=133.4397},
  {id="Shastaan", label="Shastaan", heldby="None", size=7.0, x=227.83476, y=70.061005},
  {id="Eastern Shore, the", label="Eastern Shore", heldby="None", size=7.0, x=236.98518, y=185.07915},
  {id="Maim's Mansion", label="Maim's Mansion", heldby="None", size=5.6666665, x=-743.46747, y=268.73203},
  {id="New Thera, the Village of", label="New Thera", heldby="Ashtan", size=7.666667, x=-687.548, y=205.72777},
  {id="Vashnar Mountains, the (North)", label="N. Vashnar Mountains", heldby="Mhaldor", size=8.333334, x=-932.8044, y=8.320282},
  {id="Nimick, the Village of", label="Nimick", heldby="None", size=6.3333335, x=-154.23976, y=-54.418045},
  {id="Eastern Wilderness", label="Eastern Wilderness", heldby="Hashan", size=7.0, x=194.57164, y=273.55923},
  {id="Excised Ruins of Targossas", label="Ex. Targossas", heldby="None", size=5.6666665, x=156.67372, y=94.09471},
  {id="Siroccian Mountains, the", label="Siroccian Mountains", heldby="None", size=8.333334, x=-88.68134, y=77.42571},
  {id="Dwarven Camp", label="Dwarven Camp", heldby="None", size=5.3333335, x=-189.24277, y=30.180481},
  {id="Orcish Outpost", label="Orcish Outpost", heldby="None", size=5.3333335, x=-197.15558, y=68.758965},
  {id="Pash Valley (East)", label="Pash Valley", heldby="Targossas", size=9.666666, x=-272.4786, y=-252.21877},
  {id="Bagwar's Copse", label="Bagwar's Copse", heldby="None", size=5.6666665, x=-77.58341, y=311.4773},
  {id="Lake Narcisse", label="Lake Narcisse", heldby="None", size=5.6666665, x=-141.77342, y=386.71976},
  {id="Jaru", label="Jaru", heldby="Targossas", size=7.0, x=-224.75545, y=-317.83588},
  {id="Great Southern Road", label="Great Southern Road", heldby="Cyrene", size=9.666666, x=-346.71875, y=-420.96933},
  {id="Targossas", label="Targossas", heldby="Targossas", size=20.0, x=-159.34981, y=-274.01694},
  {id="Tomacula", label="Tomacula", heldby="Mhaldor", size=5.6666665, x=-504.56995, y=-20.873798},
  {id="Creville Asylum", label="Creville Asylum", heldby="Mhaldor", size=5.6666665, x=-977.6183, y=68.9619},
  {id="Harae, the Isle of", label="Harae", heldby="Mhaldor", size=5.6666665, x=-926.814, y=-38.276638},
  {id="Xhaiden Dale", label="Xhaiden Dale", heldby="Mhaldor", size=5.6666665, x=-894.2924, y=72.69438},
  {id="Azdun Dungeon, the", label="Azdun Dungeon", heldby="Underworld", size=6.3333335, x=-574.91473, y=-181.76726},
  {id="Azdun Catacombs", label="Azdun Catacombs", heldby="Mhaldor", size=5.6666665, x=-574.91473, y=-215.66827},
  {id="Riparium", label="Riparium", heldby="None", size=5.6666665, x=296.2639, y=271.58774},
  {id="Belladona, the Keep of", label="Belladona's Keep", heldby="None", size=5.6666665, x=-196.67606, y=603.7727},
  {id="Northreach, the", label="Northreach", heldby="None", size=6.3333335, x=-325.1175, y=738.93195},
  {id="Sunderlands", label="Sunderlands", heldby="Hashan", size=7.0, x=-54.379265, y=459.5459},
  {id="Eleusis", label="Eleusis", heldby="Eleusis", size=20.0, x=104.24043, y=301.06525},
  {id="Saiha'balan Grotto", label="Saiha'balan Grotto", heldby="None", size=5.6666665, x=-622.9965, y=-423.46265},
  {id="Lake Vundamere", label="Lake Vundamere", heldby="None", size=5.6666665, x=-499.6231, y=7.6797256},
  {id="Eastern Road, the", label="Eastern Road", heldby="Hashan", size=8.333334, x=174.30797, y=441.13156},
  {id="Manusha", label="Manusha", heldby="None", size=6.3333335, x=242.97891, y=489.5004},
  {id="Enverren Marsh", label="Enverren Marsh", heldby="None", size=5.6666665, x=293.0304, y=530.2331},
  {id="Darkenwood, the", label="Darkenwood", heldby="None", size=5.6666665, x=-441.94684, y=776.76086},
  {id="Quartz Peak", label="Quartz Peak", heldby="None", size=5.6666665, x=-178.84926, y=-542.79486},
  {id="Vashnar Mountains, the (South)", label="S. Vashnar Mountains", heldby="Cyrene", size=8.333334, x=-254.27594, y=-526.094},
  {id="Kasmarkin, the City of", label="Kasmarkin", heldby="None", size=5.6666665, x=-364.2913, y=-12.609581},
  {id="Mannaseh Swamp", label="Mannaseh Swamp", heldby="Ashtan", size=7.0, x=-343.28995, y=-50.368725},
  {id="Digsite of War", label="Digsite of War", heldby="None", size=5.6666665, x=-303.33124, y=-26.009544},
  {id="Aurick Manor", label="Aurick Manor", heldby="None", size=5.6666665, x=165.78535, y=637.43835},
  {id="Tasur'ke", label="Tasur'ke", heldby="Hashan", size=7.0, x=139.18385, y=575.7084},
  {id="Ka'doloki, the Village of", label="Ka'doloki", heldby="None", size=5.6666665, x=-683.12354, y=-631.0223},
  {id="Blackrock, the Halls of", label="Blackrock Halls", heldby="Mhaldor", size=6.3333335, x=-1008.67377, y=-56.750652},
  {id="Mhaldor, the City of", label="Mhaldor", heldby="Mhaldor", size=20.0, x=-1092.3799, y=40.43073},
  {id="Underground Lake", label="Underground Lake", heldby="Mhaldor", size=5.6666665, x=-1101.0737, y=-48.88777},
  {id="Mesmerium, the", label="Mesmerium", heldby="Ashtan", size=6.3333335, x=-378.0799, y=176.78531},
  {id="Genji, the Village of", label="Genji", heldby="None", size=5.6666665, x=-330.01202, y=-494.50873},
  {id="Rhodestrian Settlement", label="Rhodestrian Settlement", heldby="None", size=5.6666665, x=-327.90567, y=-567.2984},
  {id="Sea Lion Cove", label="Sea Lion Cove", heldby="Cyrene", size=5.6666665, x=-248.1854, y=-637.24927},
  {id="Goblin Village, the", label="Goblin Village", heldby="None", size=5.6666665, x=-544.6086, y=-94.34428},
  {id="Tir Murann", label="Tir Murann", heldby="None", size=5.6666665, x=-519.6964, y=-145.6647},
  {id="Black Forest, the", label="Black Forest", heldby="None", size=7.666667, x=-679.64966, y=99.55496},
  {id="Shala'jen, the Monastery of", label="Shala'jen", heldby="None", size=6.3333335, x=-192.51485, y=-228.86105},
  {id="Halls of Battle", label="Halls of Battle", heldby="None", size=5.6666665, x=-560.83203, y=448.4489},
  {id="Theran Underground", label="Theran Underground", heldby="None", size=6.3333335, x=-740.59314, y=165.97923},
  {id="Cyrene Road", label="Cyrene Road", heldby="Cyrene", size=7.666667, x=-418.38538, y=-539.1007},
  {id="Actar, the Valley of", label="Actar", heldby="None", size=5.6666665, x=-436.35226, y=-495.1276},
  {id="Chapel of All Gods", label="Chapel of All Gods", heldby="Mhaldor", size=5.6666665, x=-289.60974, y=272.04535},
  {id="Petra, the Village of", label="Petra", heldby="Ashtan", size=6.3333335, x=-428.59283, y=446.23752},
  {id="Bog of Ashtan", label="Bog of Ashtan", heldby="Ashtan", size=7.333333, x=-352.79562, y=370.7901},
  {id="Den of the quisalis", label="Den of the Quisalis", heldby="None", size=5.6666665, x=-788.1346, y=119.10064},
  {id="Green Lake", label="Green Lake", heldby="None", size=6.3333335, x=-199.32928, y=199.81621},
  {id="Qurnok, the Village of", label="Qurnok", heldby="None", size=5.6666665, x=-199.32928, y=156.66878},
  {id="Ashtan, the City of", label="Ashtan", heldby="Ashtan", size=20.0, x=-341.30396, y=434.60272},
  {id="Forest Watch", label="Forest Watch", heldby="None", size=5.6666665, x=75.42052, y=398.27835},
  {id="Piraeus, Mount", label="Piraeus", heldby="None", size=5.6666665, x=-430.1645, y=-456.61987},
  {id="4", label="Beastlords", heldby="Mhaldor", size=5.6666665, x=-679.3212, y=29.131367},
  {id="7", label="Caer Witrin", heldby="None", size=5.6666665, x=-478.89038, y=-515.7915},
  {id="9", label="E. Pachacacha", heldby="Cyrene", size=8.333334, x=-229.75116, y=-139.5438},
  {id="11", label="S. Zaphar", heldby="Hashan", size=9.666666, x=10.889469, y=172.47145},
}
return nodes
