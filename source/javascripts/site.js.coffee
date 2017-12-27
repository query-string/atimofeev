window.Application =

  chart:
    ctx:  document.getElementById('myChart').getContext('2d')
    data: [
      # Yellow – Rails
      value: 70
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
      value: 90
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
        timeout  = 0
        branches = document.getElementsByClassName('chart--branch')
        [].forEach.call branches, (el) ->
          setTimeout (->
            #el.style.display = 'block'
            el.classList.add('chart--branch__visible')
          ), timeout
          timeout += 400

    init: ->
      myNewChart = new Chart(@ctx).Doughnut(@data, @options)

domready ->
  Application.chart.init()
