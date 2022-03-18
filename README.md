# METRO CDMX API
API that returns the CDMX routes


## How to run the API?
```
$ curl http://localhost:4000/metrocdmx/route?origin=Etiopia&dest=Normal
{
  "status": 200,
  "origin": "Etiopía",
  "dest": "Normal"
  "itinerary": [
    {
      "segment": 1,
      "line": "Línea 3",
      "origin": "Etiopía",
      "dest": "Hidalgo",
      "steps": 6
    },
    {
      "segment": 2,
      "line": "Línea 2",
      "origin": "Hidalgo",
      "dest": "Normal",
      "steps": 3
    }
  ]
}
```
