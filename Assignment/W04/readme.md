<h1>VTiOS Week 04</h1>

- Assignment - Login View

  - 1개의 View로 구성된 앱
    - 2개의 TextField로 Email, password를 받고 각각 validation이 성공하면 텍스트필드 옆에 성공표시(이미지뷰 등 자유)가 되면서 login 버튼이 활성화됨
    - login 버튼 아래에는 1초마다 올라가는 숫자를 표시
    - login 버튼을 누를 경우 Activity Indicator가 돌아가면서 아래 url의 이미지를 다운로드하여 login버튼 아래에 이미지뷰로 보여줌
    - url : "https://picsum.photos/1280/720/?random"
    - Email validation : @와 .가 있으면됩니다.
    - Password validation : 5자 이상이면 성공이라고 합시다.

  > Hint : GCD,Async<br>
  > 목표는 이미지 로딩중일때 숫자가 멈추지 않는것입니당


- Seminar
  - RxSwift입문
