roleUpgrader = run: (creep) ->
    # Switch Working State
    if creep.memory.working == true and creep.carry.energy == 0
        creep.memory.working = false
    else if creep.memory.working == false and creep.carry.energy == creep.carryCapacity
        creep.memory.working = true

    if creep.memory.working == true
        # Move to Controller
        if creep.upgradeController(creep.room.controller) == ERR_NOT_IN_RANGE
            creep.moveTo(creep.room.controller)
    else
        # Move and havest
        if creep.carry.energy == creep.carryCapacity
            creep.memory.working = true
            return
        source = creep.pos.findClosestByPath(FIND_SOURCES)
        if creep.harvest(source) == ERR_NOT_IN_RANGE
            creep.moveTo(source)

module.exports = roleUpgrader
