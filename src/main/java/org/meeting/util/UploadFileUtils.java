package org.meeting.util;

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

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;

public class UploadFileUtils {

	public static String uploadFile(String uploadPath, String originalName, byte[] fileData, String Mypath)
			throws Exception {
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;
		String savedPath = calcPath(uploadPath);
		File target = new File(uploadPath + savedPath, savedName);
		String formatName = savedName.substring(savedName.lastIndexOf(".") + 1);

		BufferedInputStream bufferedIS = new BufferedInputStream(new ByteArrayInputStream(fileData));
		ByteArrayInputStream byteIS = new ByteArrayInputStream(fileData);
		BufferedImage buffredI = rotateImageForMobile(byteIS, getOrientation(bufferedIS));
		ImageIO.write(buffredI, formatName, target);

		// FileCopyUtils.copy(fileData, target);
		// �������� ����
		String uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName, Mypath);
		return uploadedFileName;
	}

	private static String calcPath(String uploadPath) { // ���� ��¥�� ���� ������ ���� ��¥
														// ���
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

		makeDir(uploadPath, yearPath, monthPath, datePath);

		return datePath;
	}

	private static void makeDir(String uploadPath, String... paths) {
		// ���� ��¥�� ������ �ִٸ� return
		if (new File(paths[paths.length - 1]).exists())
			return;

		for (String path : paths) {

			File dirPath = new File(uploadPath + path);

			if (!dirPath.exists()) // ���� ��¥�� ������ ���ٸ� ���� ����
				dirPath.mkdir();

		}
	}

	public static int getOrientation(BufferedInputStream is) throws IOException {
		Integer orientation = 1;
		try {
			Metadata metadata = ImageMetadataReader.readMetadata(is);
			Directory directory = metadata.getDirectory(ExifIFD0Directory.class);
			try {
				if (directory != null)
					orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);

			} catch (MetadataException me) {
				System.out.println("Could not get orientation");
			}
		} catch (ImageProcessingException e) {
			e.printStackTrace();
		}
		return orientation;
	}

	public static BufferedImage rotateImageForMobile(InputStream is, int orientation) throws IOException {
		BufferedImage bi = ImageIO.read(is);

		if (orientation == 6) // ����ġ
			return rotateImage(bi, 90);

		else if (orientation == 1) // �������� ��������
			return bi;

		else if (orientation == 3) // ���������� ��������
			return rotateImage(bi, 180);

		else if (orientation == 8) // 180��
			return rotateImage(bi, 270);

		else
			return bi;

	}

	public static BufferedImage rotateImage(BufferedImage orgImage, int radians) {
		BufferedImage newImage;

		if (radians == 90 || radians == 270)
			newImage = new BufferedImage(orgImage.getHeight(), orgImage.getWidth(), orgImage.getType());

		else if (radians == 180)
			newImage = new BufferedImage(orgImage.getWidth(), orgImage.getHeight(), orgImage.getType());

		else
			return orgImage;

		Graphics2D graphics = (Graphics2D) newImage.getGraphics();

		graphics.rotate(Math.toRadians(radians), newImage.getWidth() / 2, newImage.getHeight() / 2);

		graphics.translate((newImage.getWidth() - orgImage.getWidth()) / 2,
				(newImage.getHeight() - orgImage.getHeight()) / 2);

		graphics.drawImage(orgImage, 0, 0, orgImage.getWidth(), orgImage.getHeight(), null);

		return newImage;

	}

	private static String makeThumbnail(String uploadPath, String path, String fileName, String Mypath)
			throws Exception { // ����� ���� ����
		// ���������б�
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));

		// ����� ������ ���� ����
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, 400);

		// ����� ����
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);

		// file Ȯ����
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);

		// ���� �������� ����
		String orginalFileName = uploadPath + path + File.separator + fileName;

		if (Mypath != null) // mypage���� ���ε��ϸ� ����� ��� ����
			return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');

		// mypage�� �ƴϸ� �Ϲ� ���� ��� ����
		else
			return orginalFileName.substring(uploadPath.length()).replace(File.separatorChar, '/');

	}
}
