Feature: CreateBooking
  Background:
    * def requestPayload = read('classpath:src/test/java/features/Booking/CreateBooking/CreateBooking.json');

  Scenario Outline: CreateBooking-OK-Crear reserva con datos válidos y completos
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And request requestPayload
    When method POST
    Then status 200
    * print response
    And match $response.bookingid == '#notnull'
    And match $response.booking.firstname == '#(firstname)'
    And match $response.booking.lastname == '#(lastname)'
    And match $response.booking.totalprice == '#(totalprice)'
    And match $response.booking.depositpaid == '#(depositpaid)'
    And match $response.booking.bookingdates.checkin == '#(checkin)'
    And match $response.booking.bookingdates.checkout == '#(checkout)'
    And match $response.booking.additionalneeds == '#(additionalneeds)'
    Examples:
      | firstname! |lastname!  | totalprice!  | depositpaid!  | checkin!  | checkout! | additionalneeds! |
      | "Karent" |"Checcllo" | 500 | false | "2023-01-01"  | "2023-01-01" |"Almuerzo y Cena"             |
      | "Karent" |"Checcllo" | 500 | false | "2023-01-01"  | "2023-01-01" |78                            |

  Scenario Outline: CreateBooking-OK-Crear reserva con <descripcion_caso>
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And request requestPayload
    When method POST
    Then status 200
    * print response
    And match $response.booking.<dato> == <resultado>
    Examples:
      | descripcion_caso             | firstname! |lastname!  | totalprice!| depositpaid! | checkin!     | checkout!    | additionalneeds!  |dato                   |resultado   |
      |  precio  inválido            | "Karent"   |"Checcllo" | "oeriei"   | false        | "2023-01-01" | "2023-01-01" |"Almuerzo y Cena"  |totalprice            |null        |
      |  deposito de pago inválido   | "Karent"   |"Checcllo" | 50         | "pruebas"    | "2023-01-01" | "2023-01-01" |"Almuerzo y Cena"  |depositpaid           |true        |
      |  fecha checkin vacio         | "Karent"   |"Checcllo" | 68         | true         | ""           | "2023-01-01" |"Almuerzo y Cena"  |bookingdates.checkin  |"0NaN-aN-aN"|
      |  fecha checkout  vacio       | "Karent"   |"Checcllo" | "78"       | false        | "2023-01-01" | ""           |"Almuerzo y Cena"  |bookingdates.checkout |"0NaN-aN-aN"|


  Scenario Outline: CreateBooking-NO OK-Crear reserva- <descripcion_caso>
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And request requestPayload
    When method POST
    Then status 500
     * print response
    And match response =="Internal Server Error"
    Examples:
  | descripcion_caso                       | firstname! |lastname!  | totalprice!  | depositpaid!   | checkin!  | checkout! | additionalneeds! |
  |  con nombres en null                   | null       |           |              |                |           |           |                  |
  |  con apellidos en null                 |            |    null   |              |                |           |           |                  |
  |  con total de precio en null           |            |           |  null        |                |           |           |                  |
  |  con deposito de pago en null          |            |           |              |      null      |           |           |                  |
  |  con fecha de checkin en null          |            |           |              |                |    null   |           |                  |
  |  con fecha de checkout en null         |            |           |              |                |           |    null   |                  |
  |  con necesidades adicionales en null   |            |           |              |                |           |           |    null          |
  |  con nombres en formato inválido       | 54556      |           |              |                |           |           |                  |
  |  con apellidos en formato inválido     |            |    4545   |              |                |           |           |                  |
