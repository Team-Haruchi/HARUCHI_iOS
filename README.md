# HARUCHI (하루치) iOS
<p align="center">
  <br>
<img width="1410" alt="HARUCIReadme" src="https://github.com/user-attachments/assets/578c4bf3-ce59-44af-b556-2f4e6c658048">
  <br>
</p>



## 프로젝트 소개


<p align="justify">


> 지출통제 도우미.
>
> 하루 예산을 기준으로 유동적으로 소비하세요.
>
> 지정한 한도 내에서 소비할 수 있도록 도와드립니다.
>
> 예산을 설정하시면 하루에 얼마나 쓸 수 있는지 알려드려요.
>
> 당일의 지출에 따라 그날그날의 예산을 재분배할 수도 있어요.

> </p>


<br>

## 사용 기술 및 라이브러리

#### - SwiftUI, Combine, SPM
#### - Moya, CombineMoya, FSCalendar
  
<br>

## 팀원 소개

| <img src="https://avatars.githubusercontent.com/2dubu" width="100" height="100"> | <img src="https://avatars.githubusercontent.com/sangyup12" width="100" height="100"> | <img src="https://avatars.githubusercontent.com/leeseulgi0208" width="100" height="100"> | <img src="https://avatars.githubusercontent.com/cherry-p0p" width="100" height="100"> |
|:--:|:--:|:--:|:--:|
| **두부/이건우** <br> [@2dubu](https://github.com/2dubu) | **이바/이상엽** <br> [@sangyup12](https://github.com/sangyup12) | **위즈/이슬기** <br> [@leeseulgi0208](https://github.com/leeseulgi0208) | **체리/채리원** <br> [@cherry-p0p](https://github.com/cherry-p0p) |
| 회원가입 및 로그인 뷰 (이메일 인증), 온보딩 뷰 (예산 등록 및 닉네임 지정) | 예산 탭 (예산 재분배 - 당겨쓰기, 넘기기), 메인 홈 탭 (예산 수정) | 더보기 탭 (회원정보 및 탈퇴), 캘린더 커스텀 (FSCalendar) | 메인 홈 탭 (지출 및 수입 등록, 지출 마감), 온보딩 뷰 (예산 등록 및 닉네임 지정) |

<br>

## 구현 기능

#### - 회원가입 및 로그인 뷰 (이메일 인증)  

#### - 온보딩 뷰 (예산 등록 및 닉네임 지정)

#### - 메인 홈 탭 (지출 및 수입 등록, 지출 마감, 예산 수정)

#### - 예산 탭 (예산 재분배 - 당겨쓰기, 넘기기)

#### - 더보기 탭 (회원정보 및 탈퇴)

#### - 캘린더 커스텀 (FSCalendar)

<br>

##  📣 아이디어 소개

**이번 달 생활비가 부족해… 긴축에 들어갈 때**

- 아 오늘 외식하고 싶은데…지금 이거 먹으면 앞으로 얼마나 써야 하지?
- 이거 너무 사고 싶다…어차피 이번달 월급 이미 많이 쓴 것 같은데,
다음달 월급 들어오면 진짜 가계부 써야지!
- (잔액부족) 분명히 150만원이 있었는데…? 언제 다 썼지?

📌 **가계부 앱의 문제점**

<aside>
✅ 계부를 사용하는 목적

지난 소비를 돌아보고 향후 지출을 적당한 수준으로 유지하기 위함임. 그러나, 

</aside>

1️⃣ **지출 통제가 아닌 기록에 더 초점이 맞춰져 있다.**

항상 사후적인 분석을 거쳐 이뤄지기 때문에 (즉, **회고적이기 때문에**)

매 긴축사이클/상황에 맞춘 계획적인 지출 통제란 불가능함

- 예산 설정 기능이 있는 경우도 있지만 복잡하거나 번거롭다.
- 당장 지출을 줄여야 할 때, 지금까지 얼마나 썼는지를 알아서는 부족하다.
- 월별 통계가 나오고 나서야 사후적으로, 그리고 간접적으로 지출을 관리할 수 있다.

**∴ 목적에 부합하는 기능을 제공하지 않는다**

2️⃣ **통계만을 보여준다**

- **분석**(어디서 줄여야 하고)과 **대응**(어떻게 줄일 건지)은 **이용자의 몫**

→ 지출 통제는 사후적이 아닌, 소비와 동시적으로 이루어져야 한다.
    (예측까지 가능하다면 더욱 바람직)

3️⃣ **하루에 얼마나 써야 할지 몰라서 지출의 기준을 세우기 어렵다.**

- 그래서 총예산을 단순 일할 계산하면?

   → 하루 예산을 알더라도 매일 씀씀이가 다른데…

오늘 이렇게 썼을 때 앞으로

- 하루당 얼마나 덜/더 써야 하는지
- 매일 다른 일정마다 예산을 어떻게 배분해야 할지 알기 어렵다.

<aside>
✅  결론:

돈을 아껴야 하는 사람은 

~~얼마나 썼는지~~가 중요한 게 아니라

앞으로 얼마를 쓸 수 있는지(한도 내 소비를 위한 미래의 지출기준)가 더 중요하다.

⇒ 이를 위한 기준을 제시하고자 하는 것

</aside>

<aside>
🚧 그래서,

- **직관적인 소비 기준이 제시**되고
- **하루에 얼마나 써야 할지 한눈에 보여** 지출을 관리할 수 있으면서도
- **총예산 내에서 그날그날 유동적으로 소비**할 수 있도록 돕는 앱을 기획했습니다.

- 오늘 과소비했더라도, 예산 재배치를 통해 긴축 목표를 잃지 않게 해줄 수 있습니다.
</aside>
