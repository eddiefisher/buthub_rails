(->
  $.fn.popup = (options) ->
    settings = $.extend(
      element: this
      selector: @selector
      open: ".popup_target"
      box: ".popup_container"
      close: ".close"
      width: "250px"
    , options)
    methods =
      open: (event) ->
        event.preventDefault()
        pop = $(this)
        box = $(this).parent().find(settings["box"])
        if box.css("display") is "block"
          methods.close()
        else
          methods.close()
          box_align = $($(this).parent()).data("align")
          switch box_align
            when "center"
              box.css
                display: "block"
                top: '2em'
                left: ((pop.parent().width() / 2) - box.width() / 2)

            when "left"
              box.css
                display: "block"
                top: '2em'
                left: 0

            when "right"
              box.css
                display: "block"
                top: '2em'
                right: 0

            else
              box.css
                display: "block"
                top: '2em'
                left: 0

      close: ->
        $(settings["box"]).fadeOut "fast"

    $(document).on "keyup", (event) ->
      methods.close()  if event.keyCode is 27

    $(document).on "click", (event) ->
      methods.close()  unless $(event.target).closest(settings["selector"]).length

    @each ->
      box_width = $(this).data("width")
      if box_width
        $($(this).find(settings["box"])).css width: box_width
      else
        $($(this).find(settings["box"])).css width: settings["width"]
      $(settings["open"], this).on "click", methods.open
      $(settings["open"], this).parent().find(settings["close"]).bind "click", (event) ->
        event.preventDefault()
        methods.close()


).call this
