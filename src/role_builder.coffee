roleBuilder = run: (creep) ->
    # Get Some Energy if you need to
    if creep.carry.energy <= 0
        if Game.spawns.Spawn1.transferEnergy(creep) == ERR_NOT_IN_RANGE
            creep.moveTo(Game.spawns.Spawn1)
    else
        # Build Construction Sites
        site = creep.pos.findClosestByPath(FIND_CONSTRUCTION_SITES)
        if site
            if creep.build(site) == ERR_NOT_IN_RANGE
                creep.moveTo(site)
                return

        sites = creep.room.find(FIND_CONSTRUCTION_SITES)
        if sites.length == 0
            Game.notify("Builder just suicided. Found: " + sites.length + " sites")
            creep.suicide()
            return

module.exports = roleBuilder
