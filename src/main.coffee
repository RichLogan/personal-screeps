# Imports
roleHarvester = require('role_harvester')
roleUpgrader = require('role_upgrader')

# Define Roles
BALANCED = [MOVE, CARRY, WORK]
DEFENDER = [TOUGH, TOUGH, ATTACK, MOVE]
HEALER = [TOUGH, HEAL, MOVE, MOVE]

module.exports.loop = ->
    # Free memory
    for name of Memory.creeps
        if Game.creeps[name] == undefined
            delete Memory.creeps[name]

    # Ensure 5 Worker Creeps Active
    workerCreeps = []
    for creep in Game.creeps
        if creep.memory.role == "harvester"
            workerCreeps.push(creep)
    if (workerCreeps.length < 5)
        spawner = Game.spawns.Spawn1
        if spawner.energy >= 200
            spawner.createCreep(BALANCED, memory = 'role': 'harvester')

    # Spawn some upgraders
    spawner.createCreep(BALANCED, memory = "role": 'upgrader')

    # Run All Work Units
    for name of Game.creeps
        creep = Game.creeps[name]
        if creep.memory.role == 'harvester'
            roleHarvester.run(creep)
        if creep.memory.role == 'upgrader'
            roleUpgrader.run(creep)
    return
