class WOI.Views.Pager extends Backbone.View
  events:
    'click li a' : 'loadPage'

  initialize: (options) ->
    @parentView = options.parentView
    @page       = options.initialPage
    @pages      = options.pages

    @updateVisibility()

    @$first    = @$el.find('li.first').data('page', 1)
    @$previous = @$el.find('li.previous')
    @$current  = @$el.find('li.current')
    @$next     = @$el.find('li.next')
    @$last     = @$el.find('li.last').data('page', @pages)

    @updatePageLinks()

  loadPage: (e) ->
    e.preventDefault()
    @page = parseInt $(e.currentTarget).parent().data('page'), 10
    @updatePageLinks()
    @parentView.render @page
    Backbone.trigger 'pager:change', 'page', @page, false

  updateVisibility: ->
    if @pages > 1 and @page >= 1 and @page <= @pages
      @$el.show()
    else
      @$el.hide()

  updatePageLinks: ->
    @$current.html(@page).attr('title', "Page #{@page} of #{@pages}")
    @updatePageLinksData()
    @updatePageLinksDisabled()

  updatePageLinksData: ->
    previousPage = if @page <= 1 then 1 else @page - 1
    @$previous.data 'page', previousPage

    nextPage = if @page >= @pages then @pages else @page + 1
    @$next.data 'page', nextPage

  updatePageLinksDisabled: ->
    if @page <= 1
      @$first.addClass 'disabled'
      @$previous.addClass 'disabled'
    else
      @$first.removeClass 'disabled'
      @$previous.removeClass 'disabled'

    if @page >= @pages
      @$next.addClass 'disabled'
      @$last.addClass 'disabled'
    else
      @$next.removeClass 'disabled'
      @$last.removeClass 'disabled'
