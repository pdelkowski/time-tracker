'use strict'

app.service 'LocationService', ['$http', 'API_URL', ($http, API_URL) ->

  @geocodeByAddress = (address) ->
    $http.get('http://maps.googleapis.com/maps/api/geocode/json', params:
      address: address
      region: 'pl'
      components: 'country:PL'
      sensor: false)

        # .then (response) ->
      # response.data.results.map (item) ->
        # # console.log 'in geocode'
        # # console.log item
        # item.formatted_address

  @getLocationStates = () ->
    return ['Małopolskie', 'Wielkopolskie']

  @getAvailLocationStates = () ->
    states = [
      {
        name: 'dolnoslaskie'
        label: 'Dolnośląskie'
      },
      {
        name: 'kujawsko-pomorskie'
        label: 'Kujawsko-pomorskie'
      },
      {
        name: 'lubelskie'
        label: 'Lubelskie'
      },
      {
        name: 'lodzkie'
        label: 'Łódzkie'
      },
      {
        name: 'malopolskie'
        label: 'Małopolskie'
      },
      {
        name: 'mazowieckie'
        label: 'Mazowieckie'
      },
      {
        name: 'opolskie'
        label: 'Opolskie'
      },
      {
        name: 'podkarpackie'
        label: 'Podkarpackie'
      },
      {
        name: 'podlaskie'
        label: 'Podlaskie'
      },
      {
        name: 'pomorskie'
        label: 'Pomorskie'
      },
      {
        name: 'slaskie'
        label: 'Śląskie'
      },
      {
        name: 'swietokrzyskie'
        label: 'Świętokrzystkie'
      },
      {
        name: 'warminsko-mazurskie'
        label: 'Warmińsko-mazurskie'
      },
      {
        name: 'wielkopolskie'
        label: 'Wielkopolskie'
      },
      {
        name: 'zachodniopomorskie'
        label: 'Zachodniopomorskie'
      }
    ]
    return states

  @getAvailableLocations = () ->
    return [
      {
          name: '<strong>Wszystkie lokalizacje</strong>',
          abstract: true,
          msGroup: true
      },
      {
          name: '<strong>Województwa</strong>',
          abstract: true,
          msGroup: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/POL_wojew%C3%B3dztwo_dolno%C5%9Bl%C4%85skie_COA.svg/100px-POL_wojew%C3%B3dztwo_dolno%C5%9Bl%C4%85skie_COA.svg.png" />',
          name: 'Dolnośląskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/POL_wojew%C3%B3dztwo_kujawsko-pomorskie_COA.svg/100px-POL_wojew%C3%B3dztwo_kujawsko-pomorskie_COA.svg.png" />',
          name: 'Kujawsko-Pomorskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/POL_wojew%C3%B3dztwo_lubelskie_COA.svg/100px-POL_wojew%C3%B3dztwo_lubelskie_COA.svg.png" />',
          name: 'Lubelskie',
          abstract: false,
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/POL_wojew%C3%B3dztwo_lubuskie_COA.svg/100px-POL_wojew%C3%B3dztwo_lubuskie_COA.svg.png" />',
          name: 'Lubuskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/POL_wojew%C3%B3dztwo_%C5%82%C3%B3dzkie_COA.svg/100px-POL_wojew%C3%B3dztwo_%C5%82%C3%B3dzkie_COA.svg.png" />',
          name: 'Łódzkie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/POL_wojew%C3%B3dztwo_ma%C5%82opolskie_COA.svg/100px-POL_wojew%C3%B3dztwo_ma%C5%82opolskie_COA.svg.png" />',
          name: 'Małopolskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/POL_wojew%C3%B3dztwo_mazowieckie_COA.svg/100px-POL_wojew%C3%B3dztwo_mazowieckie_COA.svg.png" />',
          name: 'Mazowieckie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/POL_wojew%C3%B3dztwo_opolskie_COA.svg/100px-POL_wojew%C3%B3dztwo_opolskie_COA.svg.png" />',
          name: 'Opolskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/POL_wojew%C3%B3dztwo_podkarpackie_COA.svg/100px-POL_wojew%C3%B3dztwo_podkarpackie_COA.svg.png" />',
          name: 'Podkarpackie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/POL_wojew%C3%B3dztwo_podlaskie_COA.svg/100px-POL_wojew%C3%B3dztwo_podlaskie_COA.svg.png" />',
          name: 'Podlaskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/POL_wojew%C3%B3dztwo_pomorskie_COA.svg/100px-POL_wojew%C3%B3dztwo_pomorskie_COA.svg.png" />',
          name: 'Pomorskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/POL_wojew%C3%B3dztwo_%C5%9Bl%C4%85skie_COA.svg/100px-POL_wojew%C3%B3dztwo_%C5%9Bl%C4%85skie_COA.svg.png" />',
          name: 'Śląskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/POL_wojew%C3%B3dztwo_%C5%9Bwi%C4%99tokrzyskie_COA.svg/100px-POL_wojew%C3%B3dztwo_%C5%9Bwi%C4%99tokrzyskie_COA.svg.png" />',
          name: 'Świętokrzyskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Warminsko-mazurskie_herb.svg/100px-Warminsko-mazurskie_herb.svg.png" />',
          name: 'Warmińsko-Mazurskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/POL_wojew%C3%B3dztwo_wielkopolskie_COA.svg/100px-POL_wojew%C3%B3dztwo_wielkopolskie_COA.svg.png" />',
          name: 'Wielkopolskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/POL_wojew%C3%B3dztwo_zachodniopomorskie_COA.svg/100px-POL_wojew%C3%B3dztwo_zachodniopomorskie_COA.svg.png" />',
          name: 'Zachodniopomorskie',
          abstract: false,
          type: 'state',
          ticked: true
      },
      {
          msGroup: false
      },
      {
          name: '<strong>Najwieksze miasta</strong>',
          abstract: true,
          msGroup: true
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Herb_wroclaw.svg/100px-Herb_wroclaw.svg.png" />',
          name: 'Wrocław',
          abstract: false,
          type: 'city',
          ticked: false
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/POL_Krak%C3%B3w_COA.svg/100px-POL_Krak%C3%B3w_COA.svg.png" />',
          name: 'Kraków',
          abstract: false,
          type: 'city',
          ticked: false
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/POL_Warszawa_COA.svg/100px-POL_Warszawa_COA.svg.png" />',
          name: 'Warszawa',
          abstract: false,
          type: 'city',
          ticked: false
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/POL_Gda%C5%84sk_COA.svg/100px-POL_Gda%C5%84sk_COA.svg.png" />',
          name: 'Gdańsk',
          abstract: false,
          type: 'city',
          ticked: false
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Katowice_Herb.svg/100px-Katowice_Herb.svg.png" />',
          name: 'Katowice',
          abstract: false,
          type: 'city',
          ticked: false
      },
      {
          icon: '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/POL_Pozna%C5%84_COA.svg/100px-POL_Pozna%C5%84_COA.svg.png" />',
          name: 'Poznań',
          abstract: false,
          type: 'city',
          ticked: false
      },
      {
          msGroup: false
      },
      {
          msGroup: false
      }
    ]

  return
]
