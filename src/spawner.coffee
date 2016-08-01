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
    if (workerCreeps.length < 7)
        if room.energyAvailable >= 200
            sources = creep.room.find(FIND_SOURCES)
            randomSource = Math.floor(Math.random() * Object.keys(sources).length)
            spawner.createCreep(BALANCED, memory = {
                'role': 'harvester',
                'target': sources[randomSource].id
            })
    else
        sites = []
        for name of Game.constructionSites
            sites.push(name)

        if (builderCreeps.length < 5 and sites.length > 0)
            if room.energyAvailable >= 200
                spawner.createCreep(BALANCED, memory = {
                    'role': 'builder',
                })
        else
            if (energyCreeps.length < 5)
                if room.energyAvailable >= 200
                    spawner.createCreep(BALANCED, memory = {
                        'role': 'energy'
                    })

module.exports = spawner
