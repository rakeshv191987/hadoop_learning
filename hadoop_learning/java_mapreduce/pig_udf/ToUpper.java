package mypigudfs;

import java.io.IOException;

import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;

public class ToUpper extends EvalFunc<String>{

	@Override
	public String exec(Tuple input) throws IOException {
		if(input == null || input.size() == 0)
			return null;
		try{
			String inp = (String)input.get(0);
			return inp.toUpperCase();
		} catch(Exception e){
			throw new IOException(e);
		}
	}

}
