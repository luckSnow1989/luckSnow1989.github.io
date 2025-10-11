package demo;

import java.io.Serializable;

import org.springframework.orm.hibernate3.HibernateTemplate;

public class BaseDaoImpl<T, PK extends Serializable> implements BaseDao<T, PK> {
	public Class entityClass;
	public HibernateTemplate ht;

	@SuppressWarnings("unchecked")
	public BaseDaoImpl(){
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType)genType).getActualTypeArguments();
		entityClass = (Class<T>)params[0];
	}
	
	public Class getEntityClass() {
		return entityClass;
	}

	public void setEntityClass(Class entityClass) {
		this.entityClass = entityClass;
	}

	public HibernateTemplate getHt() {
		return ht;
	}

	public void setHt(HibernateTemplate ht) {
		this.ht = ht;
	}

	public boolean insert(T t) {
		try{
			this.ht.save(t);
			return true;
		}catch (RuntimeException e){
			e.printStackTrace();
			return false;
		}
	}

	public boolean delete(T t) {
		try{
			this.ht.delete(t);
			return true;
		}catch (RuntimeException e){
			e.printStackTrace();
			return false;
		}
	}

	public boolean update(T t) {
		try{
			this.ht.update(t);
			return true;
		}catch (RuntimeException e){
			e.printStackTrace();
			return false;
		}
	}

	public T getById(PK pk) {
		try{
			return (T)this.ht.get(entityClass, pk);		 
		}catch (RuntimeException e){
			e.printStackTrace();
			return null;
		}
	}

}
