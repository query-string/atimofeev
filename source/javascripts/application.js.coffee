jQuery ->

  window.Application =


    shuffle: (arr) ->
      j = undefined
      x = undefined
      i = arr.length

      while i
        j = Math.floor(Math.random() * i)
        x = arr[--i]
        arr[i] = arr[j]
        arr[j] = x
      arr


    chart:

      ctx: document.getElementById('myChart').getContext('2d')

      data: [
        # Yellow – Rails
        value: 100
        color: "#f7ca00"
      ,
        # Orange – JavaScript
        value: 60
        color: "#ea6f00"
      ,
        # Brown – CSS/HTML
        value: 100
        color: "#8b3933"
      ,
        # Blue – UI/UX
        value: 50
        color: "#a6cacb"
      ,
        # Red – Ruby
        value: 70
        color: "#ad1023"
      ]

      options:
        segmentShowStroke: true
        segmentStrokeColor: "#FFF"
        segmentStrokeWidth: 5
        percentageInnerCutout: 55
        animation: true
        animationSteps: 100
        animationEasing: "easeOutBounce"
        animateRotate: true
        animateScale: false
        onAnimationComplete: ->
          timeout = 0
          Application.shuffle($('#myBranches').find('li')).each ->
            el = @
            setTimeout (->
              $(el).fadeIn('slow')
            ), timeout
            timeout += 400

      init: ->
        myNewChart = new Chart(@ctx).Doughnut(@data, @options)


  Application.chart.init()