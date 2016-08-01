tower = run: (tower) ->
    if attackEnemies(tower)
        return

    if repairStructures(tower)
        return

attackEnemies = (tower) ->
    hostiles = tower.room.find(FIND_HOSTILE_CREEPS)
    if hostiles.length > 0
        username = hostiles[0].owner.username
        Game.notify(username + " spotted in " + tower.room.name)
        tower.attack(hostiles[0])
        return true
    return false


repairStructures = (tower) ->
    structures = tower.room.find(FIND_MY_STRUCTURES)
    for structure in structures
        if structure.structureType == "rampart"
            if structure.hits < 10000
                tower.repair(structure)
                return true
        else
            if structure.hits < structure.hitsMax
                tower.repair(structure)
                return true

    allStructures = tower.room.find(FIND_STRUCTURES)
    for structure in allStructures
        # Repair Roads
        if structure.structureType == "road"
            if structure.hits < structure.hitsMax
                tower.repair(structure)
                return true

        # Repair Walls
        if structure.structureType == "structuredWall"
            if structure.hits < 5000
                tower.repair(structure)
                return true

module.exports = tower
