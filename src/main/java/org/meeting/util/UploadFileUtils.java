package org.meeting.util;

import static org.hamcrest.CoreMatchers.nullValue;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;


public class UploadFileUtils {
	
	 public static String uploadFile(String uploadPath, String originalName, byte[] fileData, String Mypath) throws Exception {
	      System.out.println("1");
		 UUID uid = UUID.randomUUID();
	      String savedName = uid.toString()+"_"+originalName;
	      System.out.println("2");
	      String savedPath = calcPath(uploadPath);
	      System.out.println("3");
	      File target = new File(uploadPath+savedPath,savedName);
	      System.out.println(savedName);
	      System.out.println(savedPath);
	      System.out.println("4");
	      String formatName = savedName.substring(savedName.lastIndexOf(".")+1);
	      System.out.println("5");
	      
	      BufferedInputStream bufferedIS = new BufferedInputStream(new ByteArrayInputStream(fileData));
	      ByteArrayInputStream byteIS = new ByteArrayInputStream(fileData);
	      BufferedImage buffredI = rotateImageForMobile(byteIS, getOrientation(bufferedIS));
	      System.out.println("6");
	      ImageIO.write(buffredI, formatName, target);
	      System.out.println("7");
	    // FileCopyUtils.copy(fileData, target);
	      //�������� ����
	      String uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName, Mypath);
	      return uploadedFileName;
	 }
	 				
	private static String calcPath(String uploadPath) {  //���� ��¥�� ���� ������ ���� ��¥ ��� 
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		makeDir(uploadPath,yearPath,monthPath,datePath);
		
		
		
		return datePath;
	}

	private static void makeDir(String uploadPath,String...paths) {
		if(new File(paths[paths.length-1]).exists()){  //���� ��¥�� ������ �ִٸ� return
			return;
		}
		for(String path: paths){
			
			File dirPath = new File(uploadPath+path);
			
			if(! dirPath.exists()){ //���� ��¥�� ������ ���ٸ� ���� ����
				dirPath.mkdir(); 
			}
		}
		// TODO Auto-generated method stub
	}
	

	 public static int getOrientation(BufferedInputStream is) throws IOException {
		 System.out.println("orientation ������");
		 		Integer orientation = 1;
	               try {
	                     Metadata metadata = ImageMetadataReader.readMetadata(is);
	                     Directory directory = metadata.getDirectory(ExifIFD0Directory.class);
	                     System.out.println("orientation ������2");
	                     try {
	                    	  System.out.println("orientation ������ ���Ⱑ ������?");
	                    	  System.out.println("sdsd");
	                    	  System.out.println(directory);
	                    	  if(directory ==null){
	                    		  System.out.println("�ù�");
	                    	  }else{
	                    		  orientation = directory.getInt(ExifIFD0Directory. TAG_ORIENTATION);
	                    	  }
	                    	   
	                           System.out.println("orientation ������ ���Ⱑ ������?2");
	                     } catch (MetadataException me) {
	                           System.out.println("Could not get orientation" );
	                     }
	              } catch (ImageProcessingException e) {
	                     e.printStackTrace();
	              }
	               System.out.println("orientation ������3");
	               return orientation;
	       }
	 
	 public static BufferedImage rotateImageForMobile(InputStream is,int orientation) throws IOException {
		 System.out.println("rotateImageForMobile ������");
            BufferedImage bi = ImageIO.read(is);

             if(orientation == 6){ //����ġ

                    return rotateImage(bi, 90);

            } else if (orientation == 1){ //�������� ��������

                    return bi;

            } else if (orientation == 3){//���������� ��������

                    return rotateImage(bi, 180);

            } else if (orientation == 8){//180��

                    return rotateImage(bi, 270);      

            } else{

                    return bi;

            }       

     }
	 
	 public static BufferedImage rotateImage(BufferedImage orgImage,int radians) {
		 System.out.println("rotateImage ������");
         BufferedImage newImage;

          if(radians==90 || radians==270){

                newImage = new BufferedImage(orgImage.getHeight(),orgImage.getWidth(),orgImage.getType());

         } else if (radians==180){

                newImage = new BufferedImage(orgImage.getWidth(),orgImage.getHeight(),orgImage.getType());

         } else{
        	 System.out.println("rotateImage ������2");
                 return orgImage;

         }

         Graphics2D graphics = (Graphics2D) newImage.getGraphics();

         graphics.rotate(Math. toRadians(radians), newImage.getWidth() / 2, newImage.getHeight() / 2);

         graphics.translate((newImage.getWidth() - orgImage.getWidth()) / 2, (newImage.getHeight() - orgImage.getHeight()) / 2);

         graphics.drawImage(orgImage, 0, 0, orgImage.getWidth(), orgImage.getHeight(), null );

         

          return newImage;

  }
	
	 private static String makeThumbnail(String uploadPath, String path, String fileName, String Mypath) throws Exception { //����� ���� ����
		  BufferedImage sourceImg = ImageIO.read(new File(uploadPath+path,fileName)); //���� ���� �б� 
	      BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,400); //����� ������ ���� ����
	      String thumbnailName = uploadPath+path+File.separator+"s_"+fileName;  //����� ����
	      File newFile = new File(thumbnailName);
	      String formatName = fileName.substring(fileName.lastIndexOf(".")+1); //file Ȯ����
	      ImageIO.write(destImg, formatName.toUpperCase(), newFile);
	      String orginalFileName =uploadPath+path+File.separator+fileName; //���� �������� ����
	      
	      if(Mypath !=null){ //mypage���� ���ε��ϸ� ����� ��� ����
	         return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar,'/');
	      }else{//mypage�� �ƴϸ�  �Ϲ� ���� ��� ����
	         return orginalFileName.substring(uploadPath.length()).replace(File.separatorChar,'/');
	      }
	   
	   }
	
}
