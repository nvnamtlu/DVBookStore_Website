package vn.fs.controller.admin;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.fs.entities.Author;
import vn.fs.entities.User;
import vn.fs.repository.AuthorRepository;
import vn.fs.repository.UserRepository;

@Controller
@RequestMapping("/admin")
public class AuthorController {

	@Autowired
	AuthorRepository authorRepository;

	@Autowired
	UserRepository userRepository;

	@ModelAttribute(value = "user")
	public User user(Model model, Principal principal, User user) {

		if (principal != null) {
			model.addAttribute("user", new User());
			user = userRepository.findByEmail(principal.getName());
			model.addAttribute("user", user);
		}

		return user;
	}

	// show list author - table list
	@ModelAttribute("authors")
	public List<Author> showAuthor(Model model) {
		List<Author> authors = authorRepository.findAll();
		model.addAttribute("authors", authors);

		return authors;
	}

	@GetMapping(value = "/authors")
	public String authors(Model model, Principal principal) {
		Author author = new Author();
		model.addAttribute("author", author);

		return "admin/authors";
	}

	// add author
	@PostMapping(value = "/addAuthor")
	public String addAuthor(@Validated @ModelAttribute("author") Author author, ModelMap model,
			BindingResult bindingResult) {

		if (bindingResult.hasErrors()) {
			model.addAttribute("error", "failure");

			return "admin/authors";
		}

		authorRepository.save(author);
		model.addAttribute("message", "successful!");

		return "redirect:/admin/authors";
	}

	// get edit author
	@GetMapping(value = "/editAuthor/{id}")
	public String editAuthor(@PathVariable("id") Long id, ModelMap model) {
		Author author = authorRepository.findById(id).orElse(null);

		model.addAttribute("author", author);

		return "admin/editAuthor";
	}

	// delete author
	@GetMapping("/deleteAuthor/{id}")
	public String delAuthor(@PathVariable("id") Long id, Model model) {
		authorRepository.deleteById(id);

		model.addAttribute("message", "Delete successful!");

		return "redirect:/admin/authors";
	}
}
