package vn.fs.commom;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Locale;
import org.thymeleaf.context.IContext;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.thymeleaf.context.Context;
import org.springframework.context.i18n.LocaleContextHolder;
import vn.fs.entities.Order;
import java.util.List;
import vn.fs.entities.CartItem;
import java.util.Collection;
import vn.fs.entities.User;
import org.springframework.ui.Model;
import org.thymeleaf.TemplateEngine;
import org.springframework.mail.javamail.JavaMailSender;
import vn.fs.repository.PublisherRepository;
import vn.fs.repository.AuthorRepository;
import vn.fs.repository.ProductRepository;
import vn.fs.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import vn.fs.repository.FavoriteRepository;
import org.springframework.stereotype.Service;

@Service
public class CommomDataService
{
    @Autowired
    FavoriteRepository favoriteRepository;
    @Autowired
    ShoppingCartService shoppingCartService;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    AuthorRepository authorRepository;
    @Autowired
    PublisherRepository publisherRepository;
    @Autowired
    public JavaMailSender emailSender;
    @Autowired
    TemplateEngine templateEngine;
    
    public void commonData(final Model model, final User user) {
        this.listCategoryByProductName(model);
        this.listAuthorByProductName(model);
        this.listPublisherByProductName(model);
        Integer totalSave = 0;
        if (user != null) {
            totalSave = this.favoriteRepository.selectCountSave(user.getUserId());
        }
        final Integer totalCartItems = this.shoppingCartService.getCount();
        model.addAttribute("totalSave", (Object)totalSave);
        model.addAttribute("totalCartItems", (Object)totalCartItems);
        final Collection<CartItem> cartItems = (Collection<CartItem>)this.shoppingCartService.getCartItems();
        model.addAttribute("cartItems", (Object)cartItems);
    }
    
    public void listCategoryByProductName(final Model model) {
        final List<Object[]> coutnProductByCategory = (List<Object[]>)this.productRepository.listCategoryByProductName();
        model.addAttribute("coutnProductByCategory", (Object)coutnProductByCategory);
    }
    
    public void listAuthorByProductName(final Model model) {
        final List<Object[]> coutnProductByAuthor = (List<Object[]>)this.productRepository.listAuthorByProductName();
        model.addAttribute("coutnProductByAuthor", (Object)coutnProductByAuthor);
    }
    
    public void listPublisherByProductName(final Model model) {
        final List<Object[]> coutnProductByPublisher = (List<Object[]>)this.productRepository.listPublisherByProductName();
        model.addAttribute("coutnProductByPublisher", (Object)coutnProductByPublisher);
    }
    
    public void sendSimpleEmail(final String email, final String subject, final String contentEmail, final Collection<CartItem> cartItems, final double totalPrice, final Order orderFinal) throws MessagingException {
        final Locale locale = LocaleContextHolder.getLocale();
        final Context ctx = new Context(locale);
        ctx.setVariable("cartItems", (Object)cartItems);
        ctx.setVariable("totalPrice", (Object)totalPrice);
        ctx.setVariable("orderFinal", (Object)orderFinal);
        final MimeMessage mimeMessage = this.emailSender.createMimeMessage();
        final MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, "UTF-8");
        mimeMessageHelper.setSubject(subject);
        mimeMessageHelper.setTo(email);
        String htmlContent = "";
        htmlContent = this.templateEngine.process("mail/email_en.html", (IContext)ctx);
        mimeMessageHelper.setText(htmlContent, true);
        this.emailSender.send(mimeMessage);
    }
}