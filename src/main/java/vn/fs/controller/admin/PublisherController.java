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

import vn.fs.entities.Publisher;
import vn.fs.entities.User;
import vn.fs.repository.PublisherRepository;
import vn.fs.repository.UserRepository;

@Controller
@RequestMapping("/admin")
public class PublisherController {

	@Autowired
	PublisherRepository publisherRepository;

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

	// show list publisher - table list
	@ModelAttribute("publishers")
	public List<Publisher> showPublisher(Model model) {
		List<Publisher> publishers = publisherRepository.findAll();
		model.addAttribute("publishers", publishers);

		return publishers;
	}

	@GetMapping(value = "/publishers")
	public String publishers(Model model, Principal principal) {
		Publisher publisher = new Publisher();
		model.addAttribute("publisher", publisher);

		return "admin/publishers";
	}

	// add publisher
	@PostMapping(value = "/addPublisher")
	public String addPublisher(@Validated @ModelAttribute("Publisher") Publisher publisher, ModelMap model,
			BindingResult bindingResult) {

		if (bindingResult.hasErrors()) {
			model.addAttribute("error", "failure");

			return "admin/publishers";
		}

		publisherRepository.save(publisher);
		model.addAttribute("message", "successful!");

		return "redirect:/admin/publishers";
	}

	// get edit publisher
	@GetMapping(value = "/editPublisher/{id}")
	public String editPublisher(@PathVariable("id") Long id, ModelMap model) {
		Publisher publisher = publisherRepository.findById(id).orElse(null);

		model.addAttribute("publisher", publisher);

		return "admin/editPublisher";
	}

	// delete publisher
	@GetMapping("/deletePublisher/{id}")
	public String delPublisher(@PathVariable("id") Long id, Model model) {
		publisherRepository.deleteById(id);

		model.addAttribute("message", "Delete successful!");

		return "redirect:/admin/publishers";
	}
}
