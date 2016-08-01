tower = require("structure_tower")

structureLogic = run: (room) ->
    structures = room.find(FIND_MY_STRUCTURES)
    for structure in structures
        if structure.structureType == "tower"
            tower.run(structure)


module.exports = structureLogic
