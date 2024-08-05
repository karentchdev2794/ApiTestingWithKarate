Feature: GetBooking

  Scenario Outline: GetBooking-<estado_caso>-Consultar reserva con <descripcion_caso>
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And path <id>
    When method GET
    Then status <status>
    * print response
    And match response <response>
    Examples:
      | estado_caso | descripcion_caso          | id   | status | response                           |
      | No OK       | identificador inexistente | 5000 | 404    | =="Not Found"                      |
      | OK          | identificador vacio       | null | 200    | contains { 'bookingid':'#notnull'} |

  Scenario Outline: GetBooking-OK-Consultar reserva con identificador existente
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And path <id>
    When method GET
    Then status 200
    * print response
    And match $response.firstname == '#notnull'
    And match $response.lastname == '#notnull'
    And match $response.depositpaid == '#notnull'
    And match $response.bookingdates.checkin == '#notnull'
    And match $response.bookingdates.checkout == '#notnull'
    And match $response.additionalneeds == '#notnull'

    Examples:
      | id  |
      | 2137 |
