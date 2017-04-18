package crud.controllers;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.AutoPopulatingList;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import crud.model.Pessoa;
import crud.model.Produto;
import crud.service.PessoaService;
import crud.validation.ProdutoValidator;

@Controller
@RequestMapping("pessoa")
public class PessoaController {


	private PessoaService pessoaService;

	public void setPessoaService(PessoaService pessoaService) {
		this.pessoaService = pessoaService;
	}

    // Manage dynamically added or removed employees
    private List<Produto> manageProdutos(Pessoa pessoa) {
        // Store the employees which shouldn't be persisted
        List<Produto> produtos2remove = new ArrayList<Produto>();
        if (pessoa.getProdutos() != null) {
            for (Iterator<Produto> i = pessoa.getProdutos().iterator(); i.hasNext();) {
                Produto produto = i.next();
                // If the remove flag is true, remove the employee from the list
                if (produto.getRemove() == 1) {
                    produtos2remove.add(produto);
                    i.remove();
                // Otherwise, perform the links
                } else {
                    produto.setPessoa(pessoa);
                }
            }
        }
        return produtos2remove;
    }

    // -- Creating a new employer ----------

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String create(@ModelAttribute Pessoa pessoa, Model model) {
        // Should init the AutoPopulatingList
        return create(pessoa, model, true);
    }

    private String create(Pessoa pessoa, Model model, boolean init) {
        if (init) {
            // Init the AutoPopulatingList
            pessoa.setProdutos(new AutoPopulatingList<Produto>(Produto.class));
        	
        	
        }
        model.addAttribute("type", "create");
        return "edit";
    }

    
    private boolean hasValidationsErrors(Pessoa pessoa, BindingResult bindingResult) {
    	
    	 if (bindingResult.hasErrors()) {
             return true;
         }
         
         if(pessoa.getProdutos()==null || pessoa.getProdutos().size() == 0){
         	bindingResult.rejectValue("msg", "pessoa.sem.produtos.pessoa.msg");
         	return true;
         }
    
         ProdutoValidator userValidator = new ProdutoValidator();
         
         for(Produto produto: pessoa.getProdutos()){
        	 if(produto.getRemove() == 0){
	        	 userValidator.validate(produto, bindingResult);
	        	 if (bindingResult.hasErrors()) {
	                  
	                 return true;
	             }	 
        	 }
         }
          
         return false;
    }
    
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("pessoa") Pessoa pessoa, BindingResult bindingResult, Model model) {

        manageProdutos(pessoa);

        if (hasValidationsErrors(pessoa,bindingResult)) {
            return create(pessoa, model, false);
        }

        // Persist the person
        pessoaService.addPessoa(pessoa);
        
        return "redirect:/pessoa/show";
    }
	
    
    // -- Updating an existing person ----------

    @RequestMapping(value = "update/{pk}", method = RequestMethod.GET)
    public String update(@PathVariable Integer pk, @ModelAttribute Pessoa pessoa, Model model) {
      
    	Pessoa p = pessoaService.getPessoaById(pk);
    	
    	model.addAttribute("type", "update");
        
        model.addAttribute("pessoa", p);
        
        return "edit";
    }

    @RequestMapping(value = "update/{pk}", method = RequestMethod.POST)
    public String update(@Valid @ModelAttribute("pessoa") Pessoa pessoa, BindingResult bindingResult, Model model) {
     	
    	List<Produto> produtos2remove = manageProdutos(pessoa);
        
        if (hasValidationsErrors(pessoa,bindingResult)) {
            return create(pessoa, model, false);
        }
     
        // First, save the person
        pessoaService.updatePessoa(pessoa);
        
        // Then, delete the previously linked products which should be now removed
        for (Produto produto : produtos2remove) {
            if (produto.getId() != null) {
                pessoaService.removeProduto(produto.getId());
            }
        }
        
        return "redirect:/pessoa/show";
    }
 
    
    @RequestMapping(value = "show", method = RequestMethod.GET)
    public String list(Model model) {
    	
    	List<Pessoa> pessoas = pessoaService.listPessoas();
    	
        model.addAttribute("pessoas", pessoas);
        
        return "list";
    } 

    @RequestMapping(value = "delete/{pk}", method = RequestMethod.GET)
    public String delete(@PathVariable Integer pk) {
        
        pessoaService.removePessoa(pk);
                 
        return "redirect:/pessoa/show";
    }
     
    
}
