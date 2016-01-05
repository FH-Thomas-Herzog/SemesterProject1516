package at.fh_ooe.swk.ufo;

import java.math.BigInteger;

import javax.xml.soap.SOAPElement;

import org.apache.axis.message.SOAPHeaderElement;

import jdk.nashorn.internal.runtime.Context.ThrowErrorManager;

public class Main {

	public static void main(String[] args) throws Throwable {
		ArtistServiceSoapStub service = (ArtistServiceSoapStub)new ArtistServiceLocator().getArtistServiceSoap();
		SOAPHeaderElement authentication = new SOAPHeaderElement("https://ufo.swk.fh-ooe.at/","Credentials");
		SOAPElement node = authentication.addChildElement("Username");
		node.addTextNode("WebApplication_1");
		SOAPElement node2 = authentication.addChildElement("Password");
		node2.addTextNode("j678ZllHOB1z~/.9eoZs@8gg,Ocl-Bqi");

		service.setHeader(authentication);
		ArtistModel model = service.getDetails(BigInteger.valueOf((long) 1));
		System.out.println(model.getFirstName());

	}

}
