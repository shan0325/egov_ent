package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class BootstrapPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public BootstrapPaginationRenderer() {
		// no-op
	}

	/*<nav aria-label="Page navigation example">
	  <ul class="pagination">
	    <li class="page-item">
	      <a class="page-link" href="#" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	    <li class="page-item"><a class="page-link" href="#">1</a></li>
	    <li class="page-item"><a class="page-link" href="#">2</a></li>
	    <li class="page-item"><a class="page-link" href="#">3</a></li>
	    <li class="page-item">
	      <a class="page-link" href="#" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	  </ul>
	</nav>*/
	
	public void initVariables(){
		firstPageLabel    = "<li class=\"page-item\"><a class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><span aria-hidden=\"true\">&laquo;</span></a></li>";
        previousPageLabel = "<li class=\"page-item\"><a class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><span aria-hidden=\"true\">&laquo;</span></a></li>";
        currentPageLabel  = "<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">{0}</a></li>";
        otherPageLabel    = "<li class=\"page-item\"><a class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a></li>";
        nextPageLabel     = "<li class=\"page-item\"><a class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><span aria-hidden=\"true\">&raquo;</span></a></li>";
        lastPageLabel     = "<li class=\"page-item\"><a class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><span aria-hidden=\"true\">&raquo;</span></a></li>";
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
