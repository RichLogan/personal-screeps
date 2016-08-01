roleHarvester = run: (creep) ->
    if creep.carry.energy < creep.carryCapacity
        # Harvest
        if creep.memory.target == undefined or creep.memory.target == null
            sources = creep.room.find(FIND_SOURCES)
            if creep.harvest(sources[0]) == ERR_NOT_IN_RANGE
                creep.moveTo(sources[0])
        else
            target = Game.getObjectById(creep.memory.target)
            if creep.harvest(target) == ERR_NOT_IN_RANGE
                creep.moveTo(target)
    else if Game.spawns.Spawn1.energy < Game.spawns.Spawn1.energyCapacity
        # Drop off
        if creep.transfer(Game.spawns.Spawn1, RESOURCE_ENERGY) == ERR_NOT_IN_RANGE
            creep.moveTo(Game.spawns.Spawn1)

module.exports = roleHarvester
