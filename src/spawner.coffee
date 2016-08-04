# Define Roles
BALANCED = [MOVE, MOVE, CARRY, CARRY, WORK, WORK]
# DEFENDER = [TOUGH, TOUGH, ATTACK, MOVE]
# HEALER = [TOUGH, HEAL, MOVE, MOVE]

generateBody: (partlist) ->
    availableEnergy = 400
    cost = 0
    for bodyPart in partList
        cost =+ BODYPART_COST[bodyPart]

spawner = spawn: (room) ->
    if room.energyAvailable < 400
        BALANCED = [WORK, CARRY, MOVE]
    else if room.energyAvailable < 600
        BALANCED = [WORK, WORK, CARRY, CARRY, MOVE, MOVE]
    else if room.energyAvailable < 800
        BALANCED = [WORK, WORK, WORK, CARRY, CARRY, CARRY, MOVE, MOVE, MOVE]
    else if room.energyAvailable < 1000
        BALANCED = [WORK, WORK, WORK, WORK, CARRY, CARRY, CARRY, CARRY, MOVE, MOVE, MOVE, MOVE]

    # Keep Track of who's who
    workerCreeps = []
    builderCreeps = []
    energyCreeps = []
    for name of Game.creeps
        creep = Game.creeps[name]
        if creep.memory.role == "harvester"
            workerCreeps.push(creep)
        if creep.memory.role == "builder"
            builderCreeps.push(creep)
        if creep.memory.role == "energy"
            energyCreeps.push(creep)

    console.log("Workers: " + workerCreeps.length)
    console.log("Builders: " + builderCreeps.length)
    console.log("Energy: " + energyCreeps.length)

    # Spawning Logic
    spawner = Game.spawns.Spawn1
    if (workerCreeps.length < 10)
        if room.energyAvailable >= 200
            sources = room.find(FIND_SOURCES)
            randomSource = Math.floor(Math.random() * Object.keys(sources).length)
            spawner.createCreep(BALANCED, memory = {
                'role': 'harvester',
                'target': sources[randomSource].id
            })
    else
        sites = []
        for name of Game.constructionSites
            sites.push(name)

        if (energyCreeps.length < 7)
            if room.energyAvailable >= 200
                spawner.createCreep(BALANCED, memory = {
                    'role': 'energy'
                })
        else
            if (builderCreeps.length < 5 and sites.length > 0)
                if room.energyAvailable >= 200
                    spawner.createCreep(BALANCED, memory = {
                        'role': 'builder',
                    })

module.exports = spawner
