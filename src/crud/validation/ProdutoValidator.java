package crud.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import crud.model.Produto;

public class ProdutoValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		 
		return Produto.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		 
		if(target==null){
			errors.rejectValue("msg", "pessoa.sem.produtos");
		} else {
		
			Produto prod = (Produto) target;
			
			if (prod.getNome()==null || prod.getNome().trim().equals("")){
				errors.rejectValue("msg", "NotEmpty.produto.nome");
			}
			
			if (prod.getValor() == null){
				errors.rejectValue("msg", "NotEmpty.produto.valor");
			}
			
		}
	}

}
