_ = require 'underscore'

BotResource = require '../resources/BotResource'

exports.mount = (app) ->
  app.get '/api/1/bots', (req, res) ->
    BotResource.List req.user.id, (err, bots) ->
      return res.locals.sendError err if err?

      res.send _(bots).invoke 'ToJSON'

  app.post '/api/1/bots', (req, res) ->
    BotResource.Deserialize req.body, (err, bot) ->
      return res.locals.sendError err if err?

      bot.Save (err, bot) ->
        return res.locals.sendError err if err?

        res.send 200, bot.ToJSON()

  app.put '/api/1/bots/:id', (req, res) ->
    BotResource.Deserialize req.body, (err, bot) ->
      return res.locals.sendError err if err?

      bot.Save (err, bot) ->
        return res.locals.sendError err if err?

      res.send 200, bot.ToJSON()

  app.get '/api/1/bots/:id/start', (req, res) ->
    BotResource.Fetch req.params.id, req.user.id, (err, bot) ->
      return res.locals.sendError err if err?

      bot.Start()

      res.send 200


  app.get '/api/1/bots/:id/stop', (req, res) ->
    BotResource.Fetch req.params.id, req.user.id, (err, bot) ->
      return res.locals.sendError err if err?

      bot.Stop()

      res.send 200


