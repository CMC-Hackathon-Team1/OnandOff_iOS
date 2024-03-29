//
//  PrivacyTermsViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/15.
//

import UIKit

final class PrivacyTermsViewController: UIViewController {
    let textView = UITextView().then {
        $0.backgroundColor = .white
        $0.font = .notoSans(size: 16)
        $0.textColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "개인정보 수집/이용약관"
        self.view.backgroundColor = .white
        self.view.addSubview(self.textView)
        
        self.textView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.bottom.equalToSuperview()
        }
        self.textView.text = text
    }
    let text = """
<On&off> (이하 ’온앤오프’)는 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 「개인정보보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을
수립 · 공개합니다.

<온앤오프>는 개인정보 처리방침을 개정하는 경우 앱 화면 및 공지사항을 통해 공지할 것입니다.

제1조 (개인정보 수집 및 이용 목적)


① <온앤오프>는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경된 경우 「개인정보 보호법」 제 18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

② <온앤오프>가 개인정보를 수집 및 이용하는 목적은 다음과 같습니다.

1. 서비스 회원가입 및 관리
    - 회원 가입의사 확인
    - 서비스 제공에 따른 본인 식별·인증
    - 회원자격 유지·관리
    - 불량회원의 부정이용 방지와 중복가입방지
    - 서비스 이용 관련 문의나 분쟁의 해결
    - 각종 고지·통지
    - 법령 등에 규정된 의무의 이행
    - 고충처리

제2조 (개인정보의 처리 및 보유 기간)


① <온앤오프>는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보 수집 시에 동의 받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.

② 개인정보 처리 및 보유 기간은 다음과 같습니다.

- 개인정보 처리 및 보유 기간 : 이용자 앱 탈퇴 시까지
- 개인정보 처리 수집 방법 : 서면 양식 (회원이 직접 입력한 정보를 수집)
- 개인정보 처리 보유 근거: 「개인정보보호법」 제15조(개인정보의 수집·이용) 제1항, 정보 주체의 동의
- 다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료 시 까지
    1. 관계 법령 위반에 따른 수사·조사 등이 진행 중인 경우에는 해당 수사·조사 종료 시까지
    2. 홈페이지 이용에 따른 채권·채무관계 잔존 시에는 해당 채권·채무관계 정산 시까지
- 관련 법령
    1. 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
    2. 대금결제 및 재화 등의 공급에 관한 기록 : 5년
    3. 계약 또는 청약철회 등에 관한 기록 : 5년

제3조 (처리하는 개인정보의 항목 작성)


① <온앤오프>는 다음의 개인정보 항목을 처리하고 있습니다.

1. 회원가입 시 기재 정보
    
    필수항목: 이메일, 비밀번호, 닉네임, 서비스 이용 기록, 접속 로그
    
2. 재화 또는 서비스 제공
    
    필수항목: 이메일, 비밀번호, 닉네임, 서비스 이용 기록, 접속 로그
    

② <온앤오프>는 서비스 가입 이용자 식별, 서비스 이용에 따른 정보 제공 및 부정 이용 확인 및 방지를 위해 수집·이용 목적을 가지고 있습니다.

제4조 (개인정보의 파기절차 및 파기방법)


① <온앤오프> 은(는) 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.

② 정보주체로부터 동의 받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.

③ 개인정보 파기의 절차, 기한 및 방법은 다음과 같습니다.

1. 파기절차
이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.
2. 파기방법
<온앤오프> 은(는) 전자적 파일 형태로 기록·저장된 개인정보는 기록을 재생할 수 없도록 파기하며, 종이 문서에 기록·저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.
3. 파기기한
이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.

제5조 (정보주체와 법정대리인의 권리 의무 및 그 행사방법에 대한 사항)


이용자는 개인정보주체로써 다음과 같은 권리를 행사할 수 있습니다.

① 정보주체는 <온앤오프>에 대해 언제든지 개인정보 열람, 정정, 삭제, 처리 정지 요구 등의 권리를 행사할 수 있습니다.

② 제1항에 따른 권리 행사는 <온앤오프>에 대해 개인정보 보호법에 따라 서면, 전자우편 등을 통하여 하실 수 있으며 <온앤오프>는 이에 대해 지체 없이 조치하겠습니다.

③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.

④ 개인정보 열람 및 처리정지 요구는 개인정보보호법 제 35조 제5항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.

⑤ 개인정보 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.

⑥ <온앤오프>는 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.

제6조 (개인정보 자동 수집 장치의 설치•운영 및 거부에 관한 사항)


<온앤오프>는 정보주체의 이용정보를 저장하고 수시로 불러오는 ‘쿠키’를 사용하지 않습니다.

제7조 (개인정보 처리방침 변경)


이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.

제8조 (개인정보의 안전성 확보 조치)


① <온앤오프>는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.

1. 개인정보 취급 직원의 최소화
개인정보를 취급하는 직원을 지정하고 담당자에 한정키셔 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.
2. 개인정보의 암호화
이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안 기능을 사용하고 있습니다.
3. 개인정보에 대한 접근
제한개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.

제9조 (개인정보 보호책임자 작성)


① <온앤오프>는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

▶ 개인정보 보호책임자

팀명 : 온앤오프

연락처 : hackathonerss@gmail.com

② 정보주체께서는 <온앤오프>의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다. <온앤오프>는 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.

제10조 (정보주체의 권익침해에 대한 구제방법)


① 정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보 침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.

1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 ([www.kopico.go.kr](http://www.kopico.go.kr/))
2. 개인정보침해신고센터 : (국번없이) 118 ([privacy.kisa.or.kr](http://privacy.kisa.or.kr/))
3. 대검찰청 : (국번없이) 1301 ([www.spo.go.kr](http://www.spo.go.kr/))
4. 경찰청 : (국번없이) 182 ([ecrm.cyber.go.kr](http://ecrm.cyber.go.kr/))

② 「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리 정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.

※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회([www.simpan.go.kr](http://www.simpan.go.kr/)) 홈페이지를 참고하시기 바랍니다.

부칙


이 약관은 2023년 02월 09일부터 시행합니다.
"""
}
