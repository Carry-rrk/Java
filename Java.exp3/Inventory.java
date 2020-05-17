/*author:rrk
 * T:2020-Spring
 * N:货物经销管理系统
 */
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

public class Inventory{
	public static void main(String[] args) throws IOException{
		Vector<Goods> vector1 = new Vector<Goods>();//货物容器
		Vector<Trade> vector2 = new Vector<Trade>();//交易命令容器
		String STORAGE1 = null,STORAGE2 = null;//读入文件后先以string存储，然后实例化变量，然后存入容器
		File INV = new File("D:\\桌面\\Java EXP\\THIRD EXP\\Inventory.txt");
		File TRA = new File("D:\\桌面\\Java EXP\\THIRD EXP\\Transactions.txt");//记录文件位置
		FileReader FRINV = new FileReader(INV);
		BufferedReader BFRINV = new BufferedReader(FRINV);
		do{
			STORAGE1 = BFRINV.readLine();
			if (STORAGE1!=null) {
				String[] STR1 = STORAGE1.split("\t");
				vector1.add(new Goods(STR1[0],Integer.parseInt(STR1[1]), STR1[2], STR1[3]));
			}
		}while(STORAGE1!=null);//货物文件读入，入容器
		FileReader FRTRA = new FileReader(TRA);
		BufferedReader BFRTRA =new BufferedReader(FRTRA);
		do{
			STORAGE2 = BFRTRA.readLine();
			if (STORAGE2!=null) {
				String[] STR2 = STORAGE2.split("\t");
				vector2.add(new Trade(STR2, STR2.length));
			}
		}while(STORAGE2!=null);//命令文件读入，入容器
		loop: do{//辨别不同的类型，并分别处理命令，loop是为了保证命令执行的顺序，即想要执行的命令完成后退出进行下一次命令
			for(int i=0;i<vector2.size();i++){//A类型的辨别
				if(vector2.get(i).TYPE.equals("A")){
					vector1.add(new Goods(vector2.get(i).ItemNum, 0, vector2.get(i).SupNum, vector2.get(i).Des));
					vector2.remove(i);
					if(vector2.size()!=0) continue loop;
					else break loop;
				}
			}
			for(int i=0;i<vector2.size();i++){//R类型辨别
				if(vector2.get(i).TYPE.equals("R")){
					for(int j=0;j<vector1.size();j++){
						if(vector2.get(i).ItemNum.equals(vector1.get(j).ItemNum)){
							vector1.get(j).Num+=vector2.get(i).InNum;
							vector2.remove(i);
							if(vector2.size()!=0) continue loop;
							else break loop;
						}
					}
				}
			}
			for(int i = 0;i<vector2.size();i++){//O类型辨别，O型辨别后首先去识别统中货码的命令，然后入容器三，容器三会对命令优先级排序
				Vector<Trade> vector3 = new Vector<Trade>();
				String TEM = null;
					if(vector2.get(i).TYPE.equals("O")){
						TEM = vector2.get(i).ItemNum;
						int TemNum = vector2.get(i).OutNum;
						vector3.add(vector2.get(i));
						for(int k=i+1;k < vector2.size();k++){
							if(vector2.get(k).TYPE.equals("O")&&vector2.get(k).ItemNum.equals(TEM)){
								if(vector2.get(k).OutNum<TemNum){
									vector3.add(0, vector2.get(k));
									TemNum = vector2.get(k).OutNum;
									vector2.remove(k);
									k--;
								}
								else {
									vector3.add(vector2.get(k));
									vector2.remove(k);
									k--;
								}
							}
						}
					
					vector2.remove(i);
					i--;
					for(int m=0;m<vector1.size();m++){
						if(vector1.get(m).ItemNum.equals(TEM)){
							for(int n=0;n<vector3.size();n++){
								if(vector3.get(n).OutNum<=vector1.get(m).Num){
									vector1.get(m).Num-=vector3.get(n).OutNum;
									PrintShipping.PrintS(vector3.get(n), vector1.get(m));
								}
								else {
									PrintError.PrintE(vector3.get(n), vector1.get(m));
								}
							}
							while (vector3.size()!=0) {
								vector3.remove(0);
							}
							if(vector2.size()!=0) continue loop;
							else break loop;
						}
					}
			}
			}
			for(int i=0;i<vector2.size();i++){//D类命令
				if(vector2.get(i).TYPE.equals("D")){
				loop2:	for(int j = 0;j<vector1.size();j++){
						if(vector1.get(j).ItemNum.equals(vector2.get(i).ItemNum)){
							if(vector1.get(j).Num==0){
								vector1.remove(j);
								vector2.remove(i);
								break loop2;
							}
							else{
								PrintError.PrintE1(vector1.get(j));
								break loop2;
							}
						}
					}
				}
		}
		}while(vector2.size()!=0);
		File file1 = new File("D:\\桌面\\Java EXP\\THIRD EXP\\NewInventory.txt");
		if(!file1.exists()){
			file1.createNewFile();
		}
		FileWriter fileWriter = new FileWriter(file1,true);
		PrintWriter pWriter = new PrintWriter(fileWriter);
		while(vector1.size()!=0){//将修改后的容器直接
			pWriter.println(vector1.get(0).ItemNum+"\t"+vector1.get(0).Num+"\t"+vector1.get(0).Sup+"\t"+vector1.get(0).Des);
			pWriter.flush();
			vector1.remove(0);
		}
		pWriter.close();
		fileWriter.close();
		BFRTRA.close();
		FRTRA.close();
		BFRINV.close();
		FRINV.close();
	}
}
