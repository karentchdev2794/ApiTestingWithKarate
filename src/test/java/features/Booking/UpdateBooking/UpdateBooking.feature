Feature: UpdateBooking
Background:
  * def requestPayload = read('classpath:src/test/java/features/Booking/UpdateBooking/requestPayload.json');

  Scenario Outline:UpdateBooking-OK-Actualizar reserva con datos válidos y completos
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path <id>
    And request requestPayload
    When method PUT
    Then status 200
    * print response
    And match $response.firstname == '#(firstname)'
    And match $response.lastname == '#(lastname)'
    And match $response.totalprice == '#(totalprice)'
    And match $response.depositpaid == '#(depositpaid)'
    And match $response.bookingdates.checkin == '#(checkin)'
    And match $response.bookingdates.checkout == '#(checkout)'
    And match $response.additionalneeds == '#(additionalneeds)'
    Examples:
      | id  | firstname! |lastname!  | totalprice!  | depositpaid!  | checkin!  | checkout! | additionalneeds! |
      |  9 | "Karent" |"Checcllo" | 500 | false | "2023-01-01"  | "2023-01-01" |"Almuerzo y Cena"             |

  Scenario Outline: UpdateBooking-No Ok-Actualizar reserva <descripcion_caso>
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path <id>
    And request requestPayload
    When method PUT
    Then status 400
    * print response
    And match response =="Bad Request"
    Examples:
      | id   | descripcion_caso                       | firstname! |lastname!  | totalprice!  | depositpaid!   | checkin!  | checkout! | additionalneeds! |
      | 1342 |  con nombres en null                   | null       |           |              |                |           |           |                  |
      | 2148 |  con apellidos en null                 |            |    null   |              |                |           |           |                  |
      | 1943 |  con total de precio en null           |            |           |  null        |                |           |           |                  |
      | 86   |  con deposito de pago en null          |            |           |              |      null      |           |           |                  |
      | 2197 |  con fecha de checkin en null          |            |           |              |                |    null   |           |                  |
      | 1601 |  con fecha de checkout en null         |            |           |              |                |           |    null   |                  |
      | 1948 |  con necesidades adicionales en null   |            |           |              |                |           |           |    null          |

  Scenario Outline: UpdateBooking-No Ok-Actualizar reserva <descripcion_caso>
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path <id>
    And request requestPayload
    When method PUT
    Then status 500
    * print response
    And match response =="Internal Server Error"
    Examples:
      | id   | descripcion_caso                          | firstname! |lastname!  | totalprice!  | depositpaid!   | checkin!  | checkout! | additionalneeds! |
      | 2197 |  con nombres en formato inválido          | 54556      |           |              |                |           |           |                  |
      | 5    |  con apellidos en formato inválido        |            |    4545   |              |                |           |           |                  |

  Scenario Outline: UpdateBooking-No Ok-Actualizar reserva con identificador de reserva inexistente
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path <id>
    And request requestPayload
    When method PUT
    Then status 405
    * print response
    And match response =="Method Not Allowed"
    Examples:
      | id   |
      | 9000  |