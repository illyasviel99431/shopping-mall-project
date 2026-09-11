package mvc.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import dto.Member;
import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final int LIST_COUNT = 5;
    private static final int PAGE_BLOCK = 5;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String command =
                request.getRequestURI()
                        .substring(request.getContextPath().length());

        try {

            switch (command) {

                case "/BoardListAction.do":
                    requestBoardList(request, response);
                    break;

                case "/BoardViewAction.do":
                    requestBoardView(request, response);
                    break;

                case "/BoardWriteForm.do":
                    requestBoardWriteForm(request, response);
                    break;

                case "/BoardWriteAction.do":
                    requestBoardWriteAction(request, response);
                    break;

                case "/BoardUpdateForm.do":
                    requestBoardUpdateForm(request, response);
                    break;

                case "/BoardUpdateAction.do":
                    requestBoardUpdateAction(request, response);
                    break;

                case "/BoardDeleteAction.do":
                    requestBoardDeleteAction(request, response);
                    break;

                default:
                    response.sendRedirect(
                            request.getContextPath()
                                    + "/BoardListAction.do?pageNum=1"
                    );
                    break;
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/BoardListAction.do?pageNum=1"
            );
        }
    }


    // =========================================================
    // 게시글 목록
    // =========================================================
    private void requestBoardList(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int pageNum =
                parsePage(request.getParameter("pageNum"));

        String searchType =
                request.getParameter("searchType");

        String keyword =
                request.getParameter("keyword");

        if (searchType == null
                || searchType.trim().isEmpty()) {

            searchType = "all";
        }

        BoardDAO dao =
                BoardDAO.getInstance();

        List<BoardDTO> boardList =
                dao.getBoardList(
                        pageNum,
                        LIST_COUNT,
                        searchType,
                        keyword
                );

        int totalCount =
                dao.getBoardCount(
                        searchType,
                        keyword
                );

        int totalPage =
                (int) Math.ceil(
                        (double) totalCount / LIST_COUNT
                );

        if (totalPage == 0) {
            totalPage = 1;
        }

        if (pageNum > totalPage) {

            pageNum = totalPage;

            boardList =
                    dao.getBoardList(
                            pageNum,
                            LIST_COUNT,
                            searchType,
                            keyword
                    );
        }

        int startPage =
                ((pageNum - 1) / PAGE_BLOCK)
                        * PAGE_BLOCK + 1;

        int endPage =
                Math.min(
                        startPage + PAGE_BLOCK - 1,
                        totalPage
                );

        request.setAttribute(
                "boardlist",
                boardList
        );

        request.setAttribute(
                "pageNum",
                pageNum
        );

        request.setAttribute(
                "totalCount",
                totalCount
        );

        request.setAttribute(
                "totalPage",
                totalPage
        );

        request.setAttribute(
                "startPage",
                startPage
        );

        request.setAttribute(
                "endPage",
                endPage
        );

        request.setAttribute(
                "searchType",
                searchType
        );

        request.setAttribute(
                "keyword",
                keyword == null ? "" : keyword
        );

        RequestDispatcher rd =
                request.getRequestDispatcher(
                        "/board/list.jsp"
                );

        rd.forward(
                request,
                response
        );
    }


    // =========================================================
    // 게시글 보기
    // =========================================================
    private void requestBoardView(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int num =
                Integer.parseInt(
                        request.getParameter("num")
                );

        BoardDTO board =
                BoardDAO.getInstance()
                        .getBoard(num);

        if (board == null) {

            showAlert(
                    response,
                    "존재하지 않는 게시글입니다.",
                    request.getContextPath()
                            + "/BoardListAction.do?pageNum=1"
            );

            return;
        }

        /*
         * 같은 브라우저 세션에서 이미 본 게시글 번호를 저장한다.
         * 목록으로 돌아온 뒤 재진입하거나 새로고침해도 Set에는 같은 번호가
         * 한 번만 들어가므로 조회수가 중복 증가하지 않는다.
         */
        HttpSession session = request.getSession();
        BoardDAO boardDao = BoardDAO.getInstance();

        synchronized (session) {

            @SuppressWarnings("unchecked")
            Set<Integer> viewedBoardNumbers =
                    (Set<Integer>) session.getAttribute(
                            "viewedBoardNumbers"
                    );

            if (viewedBoardNumbers == null) {

                viewedBoardNumbers = new HashSet<Integer>();

                session.setAttribute(
                        "viewedBoardNumbers",
                        viewedBoardNumbers
                );
            }

            if (viewedBoardNumbers.add(num)) {

                boolean increased =
                        boardDao.increaseHit(num);

                if (increased) {

                    // 화면에도 방금 증가한 조회수를 바로 표시한다.
                    board.setHit(board.getHit() + 1);

                } else {

                    // DB 증가 실패 시 다음 요청에서 다시 시도할 수 있게 한다.
                    viewedBoardNumbers.remove(num);
                }
            }
        }

        request.setAttribute(
                "board",
                board
        );

        request.getRequestDispatcher(
                "/board/view.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // 글쓰기 페이지
    // =========================================================
    private void requestBoardWriteForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {

            showAlert(
                    response,
                    "로그인이 필요합니다.",
                    request.getContextPath()
                            + "/cookie.jsp"
            );

            return;
        }

        request.getRequestDispatcher(
                "/board/write.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // 글쓰기 처리
    // =========================================================
    private void requestBoardWriteAction(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {

            showAlert(
                    response,
                    "로그인이 필요합니다.",
                    request.getContextPath()
                            + "/cookie.jsp"
            );

            return;
        }

        String subject =
                trim(request.getParameter("subject"));

        String content =
                trim(request.getParameter("content"));

        if (subject.isEmpty()
                || content.isEmpty()) {

            showAlert(
                    response,
                    "제목과 내용을 입력해 주세요.",
                    request.getContextPath()
                            + "/BoardWriteForm.do"
            );

            return;
        }

        HttpSession session =
                request.getSession(false);

        String userId =
                (String) session.getAttribute("userID");

        MemberDAO memberDAO =
                new MemberDAO();

        Member member =
                memberDAO.getMemberById(userId);

        if (member == null) {

            session.invalidate();

            showAlert(
                    response,
                    "로그인이 필요합니다.",
                    request.getContextPath()
                            + "/cookie.jsp"
            );

            return;
        }

        BoardDTO board =
                new BoardDTO();

        board.setId(
                member.getId()
        );

        board.setName(
                member.getName()
        );

        board.setSubject(
                subject
        );

        board.setContent(
                content
        );

        board.setIp(
                request.getRemoteAddr()
        );

        BoardDAO.getInstance()
                .insertBoard(board);

        response.sendRedirect(
                request.getContextPath()
                        + "/BoardListAction.do?pageNum=1"
        );
    }


    // =========================================================
    // 수정 페이지
    // =========================================================
    private void requestBoardUpdateForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {

            showAlert(
                    response,
                    "로그인이 필요합니다.",
                    request.getContextPath()
                            + "/cookie.jsp"
            );

            return;
        }

        int num =
                Integer.parseInt(
                        request.getParameter("num")
                );

        BoardDTO board =
                BoardDAO.getInstance()
                        .getBoard(num);

        if (board == null) {

            showAlert(
                    response,
                    "존재하지 않는 게시글입니다.",
                    request.getContextPath()
                            + "/BoardListAction.do?pageNum=1"
            );

            return;
        }

        if (!canManage(request, board)) {

            showAlert(
                    response,
                    "수정 권한이 없습니다.",
                    request.getContextPath()
                            + "/BoardListAction.do?pageNum=1"
            );

            return;
        }

        request.setAttribute(
                "board",
                board
        );

        request.getRequestDispatcher(
                "/board/update.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // 수정 처리
    // =========================================================
    private void requestBoardUpdateAction(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {

            showAlert(
                    response,
                    "로그인이 필요합니다.",
                    request.getContextPath()
                            + "/cookie.jsp"
            );

            return;
        }

        int num =
                Integer.parseInt(
                        request.getParameter("num")
                );

        BoardDAO dao =
                BoardDAO.getInstance();

        BoardDTO board =
                dao.getBoard(num);

        if (board == null) {

            showAlert(
                    response,
                    "존재하지 않는 게시글입니다.",
                    request.getContextPath()
                            + "/BoardListAction.do?pageNum=1"
            );

            return;
        }

        if (!canManage(request, board)) {

            showAlert(
                    response,
                    "수정 권한이 없습니다.",
                    request.getContextPath()
                            + "/BoardListAction.do?pageNum=1"
            );

            return;
        }

        String subject =
                trim(request.getParameter("subject"));

        String content =
                trim(request.getParameter("content"));

        if (subject.isEmpty()
                || content.isEmpty()) {

            showAlert(
                    response,
                    "제목과 내용을 입력해 주세요.",
                    request.getContextPath()
                            + "/BoardUpdateForm.do?num="
                            + num
            );

            return;
        }

        board.setSubject(subject);
        board.setContent(content);

        dao.updateBoard(board);

        response.sendRedirect(
                request.getContextPath()
                        + "/BoardViewAction.do?num="
                        + num
        );
    }


    // =========================================================
    // 삭제 처리
    // =========================================================
    private void requestBoardDeleteAction(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        if (!isLoggedIn(request)) {

            showAlert(
                    response,
                    "로그인이 필요합니다.",
                    request.getContextPath()
                            + "/cookie.jsp"
            );

            return;
        }

        int num =
                Integer.parseInt(
                        request.getParameter("num")
                );

        BoardDAO dao =
                BoardDAO.getInstance();

        BoardDTO board =
                dao.getBoard(num);

        if (board == null) {

            showAlert(
                    response,
                    "존재하지 않는 게시글입니다.",
                    request.getContextPath()
                            + "/BoardListAction.do?pageNum=1"
            );

            return;
        }

        if (!canManage(request, board)) {

            showAlert(
                    response,
                    "삭제 권한이 없습니다.",
                    request.getContextPath()
                            + "/BoardListAction.do?pageNum=1"
            );

            return;
        }

        dao.deleteBoard(num);

        response.sendRedirect(
                request.getContextPath()
                        + "/BoardListAction.do?pageNum=1"
        );
    }


    // =========================================================
    // 로그인 확인
    // =========================================================
    private boolean isLoggedIn(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            return false;
        }

        String userId =
                (String) session.getAttribute("userID");

        return userId != null
                && !userId.trim().isEmpty();
    }


    // =========================================================
    // 수정 / 삭제 권한 확인
    // =========================================================
    private boolean canManage(
            HttpServletRequest request,
            BoardDTO board) {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            return false;
        }

        String userId =
                (String) session.getAttribute("userID");

        return userId != null
                && userId.equals(board.getId());
    }


    private int parsePage(String value) {

        try {

            int page =
                    Integer.parseInt(value);

            return page < 1 ? 1 : page;

        } catch (Exception e) {

            return 1;
        }
    }


    private String trim(String value) {

        return value == null
                ? ""
                : value.trim();
    }



    private void showAlert(
            HttpServletResponse response,
            String message,
            String location)
            throws IOException {

        String safeMessage =
                message
                        .replace("\\", "\\\\")
                        .replace("'", "\\'");

        response.setContentType(
                "text/html; charset=UTF-8"
        );

        response.getWriter().print(
                "<script>"
                        + "alert('" + safeMessage + "');"
                        + "location.href='"
                        + location
                        + "';"
                        + "</script>"
        );
    }
}
