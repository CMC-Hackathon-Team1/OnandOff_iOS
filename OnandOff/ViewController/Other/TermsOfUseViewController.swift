//
//  TermsOfUseViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/15.
//

import UIKit

final class TermsOfUseViewController: UIViewController {
    let textView = UITextView().then {
        $0.backgroundColor = .white
        $0.font = .notoSans(size: 16)
        $0.textColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "서비스 이용약관"
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
제1조 (목적)

이 이용약관은 멀티자아 기록형 관리 서비스 <On&Off> (이하 ‘<온앤오프>’)를 이용함에 있어 애플리케이션과 회원 사이의 권리 · 의무 및 책임 사항을 규정하고 이를 이행함으로써 상호 발전을 도모하는 것으로 목적으로 합니다.

제2조 (정의)


① <온앤오프>는 재화 또는 용역(이하 ‘재화 등’)을 이용자에게 제공하기 위하여 컴퓨터나 핸드폰 등 정보통신설비를 이용한 가상의 영업장을 말하며, 아울러 앱을 운영하는 사업자의 의미로도 사용합니다.

② ’회원’이라 함은 <온앤오프>에 접속하여 이 약관에 따라 개인정보를 제공하여 회원등록을 한 자로서, <온앤오프>와의 이용 계약을 쳬결하고<온앤오프>이 제공하는 서비스를 계속적으로 이용하는 이용자를 말합니다.

제3조 (이용약관의 효력 및 변경)


① 이 약관은 서비스를 이용하고 하는 모든 이용자에 대하여 그 효력을 발생합니다.

② 이 약관은 이용자가 쉽게 알 수 있도록 <온앤오프>에 게시합니다. 다만, 약관의 내용은 이용자가 연결 화면을 통하여 볼 수 있도록 할 수 있습니다.

③ 합리적인 사유가 발생할 경우 관계법령에 위배되지 않는 범위에서 이 약관을 변경할 수 있습니다. 개정약관도 <온앤오프>에 게시됨으로써 효력이 발생합니다. 약관을 변경할 경우 지체 없이 이를 공시하여야 하고, ‘회원’의 권리나 의무 등에 관한 중요사항을 개정할 경우에는 사전에 공시하여야 합니다.

④ 변경사항은 변경 약관에 별도로 명시된 시행 일자부터 적용됩니다. 변경된 약관에 동의하지 않으면, 서비스를 사용하지 못할 수도 있습니다. 변경 약관에 동의하지 않아도, 변경 약관의 시행 일자가 지난 후에도 서비스를 계속 이용하고 있다면, 사용자가 변경된 약관에도 동의한 것으로 이해합니다. 변경된 약관을 알지 못해 발생하는 이용자의 피해는 책임지지 않습니다.

⑤ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래등에서의소비자보호에관한법률, 약관의규제등에관한법률, 공정거래위원회가 정하는 전자상거래등에서의소비자보호지침 및 관계법령 또는 상관례에 따릅니다

제4조(서비스의 제공 및 변경)


① <온앤오프>는 멀티자아 관리형 기록 서비스입니다.  <온앤오프>의 서비스의 종류와 내용은 변경될 수 있습니다.

② <온앤오프>는 다음과 같은 업무를 수행합니다.

1. 서비스에 대한 정보 제공
2. 기타 <온앤오프>가 정하는 업무

③ 서비스 이용은 <온앤오프>의 서비스 사용 승낙 직후부터 가능합니다.

④ <온앤오프>는 서비스 또는 재화 등의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 내용을 변경할 수 있습니다. 이 경우에는 변경된 내용 및 제공 일자를 명시하여 현재의 서비스 또는 재화 등의 내용을 게시한 곳에 즉시 공지합니다.

⑤ <온앤오프>가 제공하기로 ‘회원’과 계약을 체결한 서비스의 내용을 재화 등의 품절 또는 기술적 사양의 변경 등의 이유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.

⑥ 전항의 경우<온앤오프>는 이로 인하여 ‘회원’가 입은 손해를 배상합니다. 다만, ‘앱’이 고의 또는 과실이 없음을 입증하는 경우에는 그러지 아니합니다.

제5조 (서비스의 중단)


① <온앤오프>는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.

② 사업종목의 전환, 사업의 포기, 업체 간의 통합, 운영자의 불가피한 사정 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 <온앤오프>는 제 11조에 정한 방법으로 ‘회원’에게 통지하고 게시물의 이전이 쉽도록 모든 조치를 취하기 위해 노력합니다.

③ <온앤오프>는 아래에 해당하는 사유가 발생한 경우에는 ‘회원’의 서비스 이용을 제한하거나 중지시킬수 있습니다.

1. <온앤오프>가 사전에 ‘회원’에게 공지하거나 통지한 경우
2. ‘회원’이 <온앤오프> 서비스의 운영을 고의 및 과실로 방해하는 경우
3. ‘회원’이 제16조 내지는 제7조 5항을 위반한 경우
4. 서비스용 설비 점검, 보수 또는 공사로 인하여 부득이한 경우
5. 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우
6. 국가비상사태, 서비스 설비의 장애 또는 이용의 폭주 등 서비스 이용에 지장이 있을 경우
7. ‘회원’이 사기 및 악성 글 등 건전한 거래 문화 활성화 방해되는 행동을 했을 경우
8. 기타 중대한 사유로 인해 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우

④ <온앤오프>는 전항의 규정에 의하여 서비스의 이용을 제한하거나 중지한 때에는 그 사유 및 제한기간 등을 ‘회원’에게 알려야 합니다.

제6조 (회원가입 및 이용 계약 체결)


① 이용자는 <온앤오프>가 온라인으로 제공하는 가입신청양식에 따라 정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청합니다.

② 이용 계약은 ‘회원’으로 등록하여 서비스를 이용하려는 자의 본 약관 내용에 대한 동의와 가입 신청에 대하여 운영자의 이용 승낙으로 성립합니다.

③ ‘회원’으로 등록하여 서비스를 이용하려는 자는 가입 신청 시 본 약관을 읽고 가입 버튼을 선택하는 것으로 본 약관에 대한 동의 의사 표시를 합니다.

제7조 (회원 탈퇴 및 자격 상실 등)


① ‘회원’은 언제든지 <온앤오프>에서 언제든지 해지의사를 요청할 수 있으며 ‘온앤오프’는 즉시 회원탈퇴를 처리합니다. 다만, ‘회원’은 해지의사를 통지하기 전에 모든 진행 중인 서비스를 철회 또는 취소해야만 합니다. 이 경우로 인한 불이익은 회원 본인이 부담하여야 합니다.

② 해지된 경우 회원 본인 계정에 등록된 게시불 또는 회원이 작성한 게시물은 모두 삭제됩니다.

③ 본 조에 따라 해지를 한 ‘회원’은 이 약관이 정하는 이용자가입절차와 관련조항에 따라 다시 가입할 수 있습니다.

④ <온앤오프>는 이 약관에서 정한 절차에 따라 이용계약을 해지할 수 있습니다.

⑤ ’회원’이 다음 각호의 사유에 해당하는 경우, 이용계약을 해지할 수 있습니다.

1. 회원가입 신청 또는 정보 변경 시 허위 내용을 등록하거나 <온앤오프>에 통지하는 행위
2. 가입 당시 19세 미만의 아동이 법정대리인(부모 등)의 동의를 얻지 못한 경우
3. 다른 사람의 <온앤오프> 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
4. <온앤오프>를 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
5. ‘회원’ 본인이 아닌 제 3 자에게 자신의 계정 접속 권한을 부여하는 행위
6. 서비스를 이용하여 제 3 자에게 본인을 홍보할 기회를 제공하거나 제 3 자의 홍보를 대행하는 등의 방법으로 금전을 수수하거나 서비스를 이용할 권리를 양도하고 이를 대가로 금전을 수수하는 행위
7. 계정을 타인에게 판매·양도·대여하거나, 타인에게 그 이용을 허락 또는 이를 시도하는 행위
8. ‘회원’의 귀책사유로 인하여 사용자가 승인할 수 없거나 그 밖에 규정된 사항을 위반한 경우

⑥ <온앤오프>가 회원 자격을 정지시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 <온앤오프>는 회원자격을 상실시킬 수 있습니다.

⑦ 제1항 내지 제6항으로 인해 회원 탈퇴 또는 자격 상실이 된 경우 회원 정보는 다음과 같이 처리됩니다.

1. 탈퇴한 회원의 정보는 <온앤오프>의 개인정보처리방침에 규정하는 바에 따라 일정 기간 보유 후 삭제 처리됩니다.
2. 회원 자격이 상실된 회원의 정보는 회원 자격상실 확정 후 서비스 부정이용 방지 및 타 회원의 추가적인 피해 방지를 위해 2년간 보유하며 이 기간 동안 재가입 및 서비스가 불가할 수도 있습니다.

⑧ 위 사항으로 인해 회원 탈퇴 또는 자격 상실이 발생하더라도 이 약관의 유효기간 동안 발생한 ‘회원’ 또는 <온앤오프>의 권리 및 의무에 대한 책임은 사라지지 않습니다.

⑨ 이용계약의 종료와 관련하여 발생한 손해는 이용계약이 종료된 해당 ‘회원’이 책임을 부담하여야하고, <온앤오프>는 일체 책임을 지지 않습니다.

제8조 (개인정보보호)


① <온앤오프>는 ‘회원’의 개인정보 수집 시 서비스 제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집하며 ‘회원’이 동의한 목적과 범위 내에서만 이용됩니다.

② 개인정보를 수집하고자 하는 경우 ‘회원’으로부터 별도 양식에 따른 ‘개인정보처리방침(개인정보 수집 및 활용 동의서)’을 받고 있으며 ‘회원’은 언제든지 이를 철회할 수 있습니다.

③ ‘회원’은 회원가입 시 기재한 개인정보의 내용에 변경사항이 발생한 경우, 즉시 변경사항을 정정하여 기재하여야 하고, 변경의 지체로 인하여 발생한 ‘회원’의 손해에 대해 책임을 지지 않습니다.

④ <온앤오프>는 ‘정보통신망법’ 에서 정한 ‘회원’의 개인정보를 보호하기 위해 노력하고 있으며, 제 3자의 불법 침입이나 개인정보 침해로 인한 피애에 대해서는 책임지지 않습니다.

⑤ 개인정보 보호 관련 기타 상세한 사항은 <온앤오프> ‘개인정보처리방침’을 참고하시기 바랍니다.

⑥ ‘회원’은 <온앤오프>의 ‘개인정보보호정책’에 동의합니다.

제9조 (개인정보 보유 및 이용기간)


① <온앤오프>는 수집된 ‘회원’의 개인정보에 대해 수집 목적 또는 제공받은 목적이 달성되면 지체 없이 파기함을 원칙으로 합니다. 다만, 다음 각호의 경우 일정 기간 동안 예외적으로 수집한 회원정보의 전부 또는 일부를 보관할 수 있습니다.

1. 고객 요구사항 처리의 목적: 수집한 회원 정보를 회원 탈퇴 후 30일간 보유
2. 기타 <온앤오프>의 필요에 의해 별도로 동의를 얻은 경우: 별도 동의를 받은 범위(회원 정보 및 보유 기간) 내에서 보유

② 위 1항에도 불구하고 상법 및 전자상거래등에서소비자보호에관한법률 등 관련 법령의 규정에 의하여 다음과 같이 일정 기간 보유해야 할 필요가 있을 경우에는 관련 법령이 정한 기간 또는 다음 각 호의 기간 동안 회원 정보를 보유할 수 있습니다.

1. 계약 또는 청약 철회 등에 관한 기록: 5년
2. 대금결제 및 재화 등의 공급에 관한 기록: 5년
3. 소비자의 불만 또는 분쟁 처리에 관한 기록: 3년

제10조 (개인정보 보호를 위한 ‘회원’의 권리)


① ‘회원’은 회원 탈퇴를 통해 이 약관과 관련한 개인정보의 제공 및 활용과 관련한 동의를 철회할 수 있습니다. 그 경우에도 <온앤오프>은 제9조에 한하여 회원 정보를 보유할 수 있습니다.

② ‘회원’은 <온앤오프>이 고지한 개인정보보호책임자에게 본인의 개인정보에 대한 열람을 요구할 수 있으며, 자신의 개인정보에 오류가 있는 경우 <온앤오프>을 통해 직접 처리하거나 개인정보보호책임자에게 정정을 요구할 수 있습니다.

③ ’회원’은 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 기재한 사항이 변경되었을 경우에는 즉시 변경사항을 최신의 정보로 수정하여야 합니다. 단, 허위 정보를 제공하여서는 안 됩니다.

④ 수정하지 않는 정보로 말미암아 발생하는 손해는 해당 ‘회원’이 부담하며, <온앤오프>는 이에 대해 아무런 책임을 지지 않습니다.

⑤ <온앤오프>는 ‘회원’으로부터 위 1항의 규정에 의한 동의 철회 및 위 2항의 규정에 의한 열람 및 정정 요구를 받은 경우에는 지체 없이 필요한 조치를 취하도록 합니다.

제11조 (’회원’에 대한 통지)


① <온앤오프>이 회원에 대한 통지를 하는 경우, 회원이 <온앤오프>과 미리 약정하여 지정한 이메일 주소로 할 수 있습니다.

② <온앤오프>은 불특정다수 회원에 대한 통지의 경우 1주일 이상 <온앤오프> 내 게시함으로써 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별 통지를 합니다.

제12조 (’회원’의 ID 및 비밀번호에 대한 의무)


① 개인정보처리방침에서 규정된 경우를 제외한 ID와 비밀번호에 관한 관리 책임은 ‘회원’에게 있습니다.

② ‘회원’은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.

③ ‘회원’이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 <온앤오프>에 통보하고 <온앤오프>의 안내가 있는 경우에는 그에 따라야 합니다.

④<온앤오프>는 다음의 지시를 따르지 않음으로써 발생하는 불이익에 대해 책임을 지지 않습니다.

제13조 (’회원’의 의무)


① ‘회원’은 다음 행위를 하여서는 아니 되며, 이에 대한 법률적인 책임은 이용자에게 있습니다. 다음과 같은 행위를 금지합니다.

A. 서비스 일반

1. 서비스 내에 외설적인, 선정적인 또는 폭력적인 내용이 담긴 내용, 불법 단체에가입을 권유하는 내용, 미성년자에게 유해한 내용을 게시하는 행위
2. 다른 ‘회원’의 개인정보를 그 동의 없이 수집, 저장, 공개하는 행위
3. <온앤오프> 서비스 관리자를 가장하거나 사칭하는 행위
4. <온앤오프>가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
5. <온앤오프> 기타 제3자의 저작권 등 지적재산권에 대한 침해
6. <온앤오프> 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 광고성 정보를 전송하기 위하여 서비스를 이용하는 행위
8. 스팸 및 홍보, 음란성, 욕설/생명경시/혐오/차별적, 도배 등 행위로 다른 회원의서비스 이용을 방해하는 행위
9. 기타 불법적이거나 부당한 행위

B. 계정 관련

1. 회원가입 신청 또는 정보 변경 시 허위 내용을 등록하거나 <온앤오프>에 통지하는행위
2. 타인의 정보를 도용하는 행위
3. ‘회원’ 본인이 아닌 제3자에게 자신의 계정 접속 권한을 부여하는 행위
4. 서비스를 이용하여 제3자에게 본인을 홍보할 기회를 제공하거나 제3자의홍보를 대행하는 등의 방법으로 금전을 수수하거나 서비스를 이용할 권리를 양도하고 이를 대가로금전을 수수하는 행위
5. 계정을 타인에게 판매·양도·대여하거나, 타인에게 그 이용을 허락 또는 이를 시도하는행위

② ‘회원’은 관계 법령, 본 약관의 규정, 이용안내 및 서비스상에 공지한 주의사항, 회사가 통지하는 사항 등을 지켜야 하며, 기타 <온앤오프>의 업무에 방해되는 행위를 하여서는 안 됩니다.

③ ‘회원’이 본 조 제1항에 명시된 행위를 하였을 때 <온앤오프>는 부가적으로 제공한 혜택의 일부 또는 전부의 회수, 특정 서비스의 이용 제한, 이용계약 해지 및 손해배상 청구 등 법적인 조치를 취할 수 있습니다.

제14조 (<온앤오프>의 의무)


① <온앤오프>는 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고 안정적으로 서비스를 제공하는 데 최선을 다하여야 합니다. 다만, 천재지변 또는 <온앤오프>에 부득이한 사유가 있는 경우, 서비스 운영을 일시 정지할 수 있습니다.

② <온앤오프>는 ‘회원’이 원하지 않는 영리 목적의 광고성 전자우편을 발송하지 않습니다.

제15조 (게시물의 관리)


① ‘회원’의 게시물이 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 “정보통신망법”)및 저작권법 등 관련 법령에 위반되는 내용을 포함하는 경우, 권리자는 <온앤오프>에 관련 법령이 정한 절차에 따라 해당 게시물의 게시중단 및 삭제 등을 요청할 수 있으며, <온앤오프>는 관련 법령에 따라 조치를 취합니다.

② <온앤오프>는 권리자의 요청이 없는 경우라도 권리침해가 인정될 만한 사유가 있거나 기타 <온앤오프>의 정책 및 관련 법령에 위반되는 경우에는 관련 법령에 따라 해당 게시물에 대해 임시조치 등을 취할 수 있습니다.

③ <온앤오프>는 서비스 이용을 위하여 양도불가능하고 무상의 라이선스를 ‘회원’에게 제공합니다. 다만, <온앤오프> 상표 및 로고를 사용할 권리를 사용자분들에게 부여하는 것은 아닙니다.

제16조 (저작권의 귀속 및 이용제한)


① <온앤오프>가 ‘회원’에게 제공하는 상표, 로고, 서비스 및 광고 등 <온앤오프>이 제작, 제공하는 것에 대한 지식재산권 등의 권리는 <온앤오프>에 귀속합니다.

② ‘회원’이 서비스를 이용하는 과정에서 작성한 게시물 등에 대한 저작권을 포함한 일체의 권리와 책임은 각 ‘회원’에게 있습니다. 또한 <온앤오프>은 ‘회원’의 동의 없이 게시물을 상업적으로 이용할 수 없습니다. 다만 비영리 목적인 경우는 그러하지 아니하며, 또한 서비스 내의 게재건을 갖습니다.

③ ‘회원’은 서비스를 이용하여 취득한 정보를 임의 가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적으로 사용할 수 없습니다.

④ 정보통신윤리위원회 등 공공기관의 시정요구가 있는 경우 운영자는 회원의 사전동의 없이 게시물을 삭제하거나 이동 또는 등록 거부할 수 있습니다.

⑤ 불량 게시물의 판단 기준은 다음과 같습니다.

1. 불법 복제 또는 해킹을 조장하는 내용인 경우
2. 범죄와 결부된다고 객관적으로 인정되는 내용일 경우
3. 다른 이용자 또는 제 3자와 저작권 등 기타 권리를 침해하는 경우
4. 공공질서 및 미풍양속에 위반되는 내용을 유포하거나 링크시키는 경우
5. 기타 관계법령에 위배된다고 판단되는 경우

⑥ <온앤오프>는 게시물 등에 대하여 제 3자로부터 명예훼손, 지적재산권 등의 권리 침해를 이유로 게시 중단 요청을 받은 경우 이를 임시로 게시중단할 수 있으며, 게시 중단 요청자와 게시물 등록자 간에 소송, 합의 기타 이에 준하는 관련 기관의 결정 등이 이루어져 운영자에게 접수된 경우 이에 따릅니다.

⑦ ‘회원’이 게시한 게시물 등의 저작권은 해당 게시물의 저작자에게 귀속됩니다.

⑧ 게시물 등은 사이트를 통해 노출될 수 있으며, 검색결과 내지 관련 프로모션 등에도 노출될 수 있습니다. 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 복제, 편집되어 게시될 수 있습니다. 이 경우, <온앤오프>는 저작권법 규정을 준수하며, ‘회원’은 언제든지 각 서비스 내 관리기능을 통해 해당 게시물 등에 대해 삭제, 검색결과 제외, 비공개 등의 조치를 취할 수 있습니다.

제17조 (서비스 이용책임)


① ‘회원’은 <온앤오프>의 적법한 권한 있는 자로부터 구체적으로 명시적인 사전 서면 승인을 받은 경우를 제외하고는,<온앤오프>를 이용하여 상품/서비스를 판매하는 영업활동을 할 수 없으며 특히 해킹, 돈벌이 광고, 음란 사이트 등을 통한 상업행위, 상용 S/W 불법 배포 등을 할 수 없습니다. 이를 어기고 발생한 영업활동의 결과 및 손실, 관계기관에 의한 구속 등 법적 조치 등에 관해서는 <온앤오프>이 책임지지 않으며 모든 민, 형법상 책임은 ‘회원’ 본인에게 1차적으로 있습니다.

② <온앤오프>는 법령상 허용되는 한도 내에서 서비스와 관련하여 본 약관에 명시되지 않은 어떠한 구체적인 사항에 대한 약정이나 보증을 하지 않습니다. 예를 들어, <온앤오프>는 <온앤오프>서비스에 속한 콘텐츠, 서비스의 특정 기능, 서비스의 이용가능성에 대하여 어떠한 약정이나 보증을 하는 것이 아니며, <온앤오프> 서비스를 있는 그대로 제공할 뿐입니다.

제18조 (약관에서 정하지 않은 사항)


이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관련법령 및 상관례에 따릅니다.

제19조 (면책)


① <온앤오프>는 ‘회원’이 서비스 제공으로부터 기대되는 이익을 얻지 못하였거나 서비스 자료에 대한 취사선택 또는 이용으로 발생하는 손해 등에 대해서는 책임이 면제됩니다.

② <온앤오프>는 본 서비스 기반 타 통신업자가 제공하는 전기통신서비스의 장애로 인한 경우에는 책임이 면제되며 본 서비스 기반과 관련되어 발생한 손해에 대해서는 서비스의 이용약관에 준합니다.

③ <온앤오프>는 ‘회원’의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 부담하지 않습니다.

④ <온앤오프>는 ‘회원’이 ‘앱’이 저장, 게시 또는 전송한 자료와 관련하여 일체의 책임을 지지 않습니다.

⑤ <온앤오프>는 ‘회원’ 상호 간 또는 ‘회원’과 제 3자 상호 간, 기타 ‘회원’의 본 서비스 내외를 불문한 일체의 활동(데이터 전송, 기타 커뮤니티 활동 포함)에 대하여 책임지지 아니합니다.

⑥ <온앤오프>는 ‘회원’이 게시 또는 전송한 자료 및 본 서비스로 회원이 제공 받을 수 있는 모든 자료들의 진위, 신뢰도, 정확성 등 그 내용에 대해서는 책임지지 아니합니다.

⑦ <온앤오프>는 서비스 이용과 관련하여 ‘회원’에게 발생한 손해 가운데 ‘회원’의 고의, 과실에 의한 손해에 대하여 책임을 부담하지 않습니다.

⑧ <온앤오프>는 ‘회원’ 상호 간 또는 ‘회워’과 제 3자 상호간에 서비스를 매개로 하여 물품 거래 등을 한 경우에 그로부터 발생하는 일체의 손해에 대하여 책임지지 아니합니다.

⑨ <온앤오프>는 ‘회원’ 간 또는 ‘회원’과 제 3자 간에 발생한 일체의 분쟁에 대하여 책임지지 아니합니다.

⑩ 운영자는 서버 등의 설비의 관리, 점검, 보수, 교체 과정 또는 소프트웨어의 운용 과정에서 고의 또는 고의에 준하는 중대한 과실 없이 발생할 수 있는 시스템의 장애, 제 3자의 공격으로 인한 시스템의 장애, 국내 외의 저명한 연구 기관이나 보안 관련 업체에 의해 대응 방법이 개발되지 아니한 컴퓨터 바이러스 등의 유포나 기타 운영자가 통제할 수 없는 불가항력적 사유로 인한 회원의 손해에 대하여 책임지지 아니합니다.

제20조 (분쟁해결)


<온앤오프>와 ‘회원’ 간에 발생한 전자상거래 분쟁과 관련하여 ‘회원’의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.

제21조 (재판권 및 준거법)


① 이 약관은 대한민국법에 의하여 규정되고 이행되며, <온앤오프>와 ‘회원’ 간에 제기된 소송에는 대한민국법을 적용합니다.

② ‘서비스’ 이용과 관련하여 <온앤오프>와 ‘회원’ 간에 발생한 분쟁은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.

부칙

이 약관은 2023년 02월 09일부터 시행합니다.
"""
}
