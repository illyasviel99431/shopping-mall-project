(function () {
    "use strict";

    var STORAGE_KEY = "illya-language";
    var memoryLanguage = "ko";

    /* data-i18n이 없는 기존 공통 문구도 최소한으로 전환한다. */
    var commonTranslations = {
        "홈": "Home",
        "상품 목록": "Shop",
        "게시판": "Community",
        "마이페이지": "My Account",
        "로그인": "Sign in",
        "회원가입": "Create account",
        "프로필": "Profile",
        "장바구니": "Cart",
        "로그아웃": "Sign out",
        "상품": "Product",
        "상품명": "Product name",
        "상품 상세 정보": "Product details",
        "상품 코드": "Product code",
        "제조사": "Maker",
        "분류": "Category",
        "재고 수": "In stock",
        "판매가": "Price",
        "가격": "Price",
        "수량": "Quantity",
        "장바구니 담기": "Add to cart",
        "목록으로": "Back to shop",
        "상세 정보": "View details",
        "전체 상품 보기": "View all products",
        "검색 결과": "Search results",
        "검색 결과가 없습니다.": "No products matched your search.",
        "배송 정보": "Delivery details",
        "배송지 정보": "Delivery address",
        "수령인 이름": "Recipient name",
        "연락처": "Phone number",
        "우편번호": "Postal code",
        "주소": "Address",
        "배송 요청일": "Preferred delivery date",
        "주문 확인": "Review order",
        "결제 정보": "Order summary",
        "총 결제 금액": "Total",
        "수정하기": "Edit",
        "결제하기": "Place order",
        "주문 취소": "Cancel order",
        "주문 오류": "Order issue",
        "상품 등록": "Add product",
        "상품 수정": "Edit products",
        "상품 삭제": "Delete products",
        "글쓰기": "Write post",
        "글 수정": "Edit post",
        "삭제": "Delete",
        "제목": "Title",
        "내용": "Content",
        "작성자": "Author",
        "조회수": "Views",
        "등록일": "Date",
        "번호": "No.",
        "이전": "Previous",
        "다음": "Next",
        "취소": "Cancel",
        "수정": "Edit",
        "확인": "Confirm",
        "아이디": "User ID",
        "이름": "Name",
        "성별": "Gender",
        "생년월일": "Date of birth",
        "이메일": "Email",
        "전화번호": "Phone",
        "비밀번호": "Password",
        "관리자 모드": "Admin mode",
        "문의": "Contact Us",
        "바로가기": "Quick Menu",
        "온라인 쇼핑몰": "Online Shopping Mall",
        "모든 권리 보유.": "All Rights Reserved."
    };

    /* 기존 footer처럼 영어로 작성된 고정 문구도 첫 로드에서 한국어로 맞춘다. */
    function readStoredLanguage() {
        try {
            var stored = window.localStorage.getItem(STORAGE_KEY);
            if (stored === "en" || stored === "ko") {
                memoryLanguage = stored;
            }
        } catch (error) {
            /* private mode 등 저장소를 못 쓰는 환경에서는 현재 화면에서만 유지한다. */
        }

        return memoryLanguage;
    }

    function storeLanguage(language) {
        memoryLanguage = language;

        try {
            window.localStorage.setItem(STORAGE_KEY, language);
        } catch (error) {
            /* 버튼 기능은 저장소가 없어도 정상 동작한다. */
        }
    }

    function translateMarkedElements(language) {
        document.querySelectorAll("[data-i18n]").forEach(function (element) {
            var translated = element.getAttribute("data-" + language);

            if (translated !== null) {
                element.textContent = translated;
            }
        });

        document.querySelectorAll("[data-i18n-placeholder]").forEach(function (element) {
            var placeholder = element.getAttribute("data-" + language + "-placeholder");

            if (placeholder !== null) {
                element.setAttribute("placeholder", placeholder);
            }
        });

        document.querySelectorAll("[data-i18n-title]").forEach(function (element) {
            var title = element.getAttribute("data-" + language + "-title");

            if (title !== null) {
                element.setAttribute("title", title);
            }
        });
    }

    function translateCommonText(language) {
        if (!document.body || !document.createTreeWalker) {
            return;
        }

        var nodeFilter = window.NodeFilter || {
            SHOW_TEXT: 4,
            FILTER_ACCEPT: 1,
            FILTER_REJECT: 2
        };
        var translations = {};

        Object.keys(commonTranslations).forEach(function (korean) {
            var english = commonTranslations[korean];
            translations[language === "en" ? korean : english] = language === "en" ? english : korean;
        });

        var walker = document.createTreeWalker(document.body, nodeFilter.SHOW_TEXT, {
            acceptNode: function (node) {
                var parent = node.parentNode;

                if (!parent || /^(SCRIPT|STYLE|TEXTAREA)$/i.test(parent.nodeName)) {
                    return nodeFilter.FILTER_REJECT;
                }

                return nodeFilter.FILTER_ACCEPT;
            }
        });
        var nodes = [];
        var current;

        while ((current = walker.nextNode())) {
            nodes.push(current);
        }

        nodes.forEach(function (node) {
            var original = node.nodeValue;
            var leading = (original.match(/^\s*/) || [""])[0];
            var trailing = (original.match(/\s*$/) || [""])[0];
            var value = original.trim();
        });
    }

    function updateSwitchButton(language) {
        var switcher = document.getElementById("languageSwitcher");
        var switcherLabel = document.getElementById("languageSwitcherLabel");

        if (!switcher || !switcherLabel) {
            return;
        }

        var isKorean = language === "ko";
        switcherLabel.textContent = isKorean ? "EN" : "KO";
        switcher.setAttribute(
            "aria-label",
            isKorean ? "Switch language to English" : "한국어로 전환"
        );
        switcher.setAttribute("title", isKorean ? "English" : "한국어");
        switcher.classList.toggle("is-english", !isKorean);
    }

    function notifyLanguageChanged(language) {
        var event;

        if (typeof window.CustomEvent === "function") {
            event = new CustomEvent("illyaLanguageChanged", {
                detail: { language: language }
            });
        } else {
            event = document.createEvent("CustomEvent");
            event.initCustomEvent("illyaLanguageChanged", false, false, {
                language: language
            });
        }

        window.dispatchEvent(event);
    }

    function applyLanguage(language) {
        var nextLanguage = language === "en" ? "en" : "ko";

        document.documentElement.lang = nextLanguage;
        document.documentElement.setAttribute("data-language", nextLanguage);
        translateMarkedElements(nextLanguage);
        translateCommonText(nextLanguage);
        updateSwitchButton(nextLanguage);
        notifyLanguageChanged(nextLanguage);
    }

    function setLanguage(language) {
        var nextLanguage = language === "en" ? "en" : "ko";
        storeLanguage(nextLanguage);
        applyLanguage(nextLanguage);
    }

    function initializeLanguage() {
        var switcher = document.getElementById("languageSwitcher");

        applyLanguage(readStoredLanguage());

        if (switcher && switcher.dataset.languageReady !== "true") {
            switcher.dataset.languageReady = "true";
            switcher.addEventListener("click", function (event) {
                event.preventDefault();
                event.stopPropagation();
                setLanguage(readStoredLanguage() === "ko" ? "en" : "ko");
            });
        }
    }

    window.ILLYALanguage = {
        get: readStoredLanguage,
        set: setLanguage,
        apply: applyLanguage
    };

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", initializeLanguage);
    } else {
        initializeLanguage();
    }
})();
