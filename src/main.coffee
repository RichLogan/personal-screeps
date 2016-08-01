# Imports
spawner = require 'spawner'
roleHarvester = require 'role_harvester'
roleUpgrader = require 'role_upgrader'
roleBuilder = require 'role_builder'
roleEnergyMonitor = require "role_energyMonitor"
structures = require "structure"

module.exports.loop = ->
    # Free memory
    for name of Memory.creeps
        if Game.creeps[name] == undefined
            delete(Memory.creeps[name])

    for room of Game.rooms
        currentRoom = Game.rooms[room]
        spawner.spawn(currentRoom)
        structures.run(currentRoom)

        # Run All Work Units
        for name of Game.creeps
            creep = Game.creeps[name]
            if creep.memory.role == 'harvester'
                roleHarvester.run(creep)
            if creep.memory.role == 'builder'
                roleBuilder.run(creep)
            if creep.memory.role == 'energy'
                roleEnergyMonitor.run(creep)
