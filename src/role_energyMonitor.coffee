roleEnergyMonitor = run: (creep) ->
    # Get Some Energy
    if creep.carry.energy <= 0
        if Game.spawns.Spawn1.transferEnergy(creep) == ERR_NOT_IN_RANGE
            creep.moveTo(Game.spawns.Spawn1)
            return

    # Check on Extensions
    extensions = creep.room.find(FIND_MY_STRUCTURES, {
        filter: { structureType: STRUCTURE_EXTENSION }
    })
    for extension in extensions
        if refuel(creep, extension)
            return

    # Check on towers
    towers = creep.room.find(FIND_MY_STRUCTURES, {
        filter: { structureType: STRUCTURE_TOWER }
    })
    for tower in towers
        if refuel(creep, tower)
            return

    # Nothing else, give to Controller
    if creep.upgradeController(creep.room.controller) == ERR_NOT_IN_RANGE
        creep.moveTo(creep.room.controller)
        return

refuel = (creep, structure) ->
    if structure.energy < structure.energyCapacity and structure != null
        if creep.transfer(structure, RESOURCE_ENERGY) == ERR_NOT_IN_RANGE
            creep.moveTo(structure)
            return true
    return false

module.exports = roleEnergyMonitor
