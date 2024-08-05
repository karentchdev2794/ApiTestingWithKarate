Feature: PartialUpdateBooking
  Background:
* def requestAllPayload = read('classpath:src/test/java/features/Booking/PartialUpdateBooking/requestAllPayload.json');

* def requestFirstName = read('classpath:src/test/java/features/Booking/PartialUpdateBooking/requestFirstName.json');

* def requestLastName = read('classpath:src/test/java/features/Booking/PartialUpdateBooking/requestLastName.json');

* def requestTotalPrice = read('classpath:src/test/java/features/Booking/PartialUpdateBooking/requestTotalPrice.json');

* def requestDepositPaid = read('classpath:src/test/java/features/Booking/PartialUpdateBooking/requestDepositPaid.json');

* def requestBookingDates = read('classpath:src/test/java/features/Booking/PartialUpdateBooking/requestBookingDates.json');

* def AdditionalNeeds = read('classpath:src/test/java/features/Booking/PartialUpdateBooking/AdditionalNeeds.json');


  Scenario Outline:PartialUpdateBooking-OK-Actualizar Parcialmente una reserva con <descripcion_caso>
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path <id>
    And request <requestAPayload>
    When method PATCH
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
      | id |descripcion_caso                  | requestAPayload    | firstname! |lastname!   | totalprice! | depositpaid! | checkin!     | checkout!    | additionalneeds! |
      |  9 |datos completos y válidos         | requestAllPayload  | "Karent"   |"Checcllo"  | 500         | false        | "2023-01-01" | "2023-01-01" |"Almuerzo y Cena" |

  Scenario Outline:PartialUpdateBooking-OK-Actualizar Parcialmente una reserva con <descripcion_caso>
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path <id>
    And request <requestAPayload>
    When method PATCH
    Then status 200
    * print response
    And match $response.<dato> == <resultado>
    Examples:
      | id | descripcion_caso                | requestAPayload     | firstname! | lastname!  | totalprice! | depositpaid! | checkin!     | checkout!    | additionalneeds! | dato                  | resultado       |
      | 9  | con deposito de pago nulo       | requestDepositPaid  |            |            |             | null         |              |              |                  | depositpaid           | false           |
      | 9  | con fecha checkin  nula         | requestBookingDates |            |            |             |              | null         |              |                  | bookingdates.checkin  | "1970-01-01"    |
      | 9  | con fecha checkout nula         | requestBookingDates |            |            |             |              |              |              |                  | bookingdates.checkout | "1970-01-01"    |
      | 9  | nombres válidos                 | requestFirstName    | "Lucia"    |            |             |              |              |              |                  | firstname             | "Lucia"         |
      | 9  | apellidos válidos               | requestLastName     |            | "Gonzales" |             |              |              |              |                  | lastname              | "Gonzales"      |
      | 9  | precio válido                   | requestTotalPrice   |            |            | 700         |              |              |              |                  | totalprice            | 700             |
      | 9  | deposito de pago válido         | requestDepositPaid  |            |            |             | false        |              |              |                  | depositpaid           | false           |
      | 9  | fecha de checkin válidos        | requestBookingDates |            |            |             |              | "2023-01-01" | "2023-01-01" |                  | bookingdates.checkin  | "2023-01-01"    |
      | 9  | fecha de Checkout válidos       | requestBookingDates |            |            |             |              | "2023-01-01" | "2023-01-01" |                  | bookingdates.checkout | "2023-01-01"    |
      | 9  | necesidades adicionales válidas | AdditionalNeeds     |            |            |             |              |              |              | Cena y Frutas    | additionalneeds       | "Cena y Frutas" |

  Scenario Outline: PartialUpdateBooking-No Ok-Actualizar reserva inexistente
    Given url 'https://restful-booker.herokuapp.com/booking/'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path <id>
    And request requestAllPayload
    When method PATCH
    Then status 405
    * print response
    And match response =="Method Not Allowed"
    Examples:
      | id    |
      | 67888 |